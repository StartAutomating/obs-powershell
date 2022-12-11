#requires -Module PipeScript


# The WebSocket is nice enough to provide it's documentation in JSON
$obsWebSocketProtocol = Invoke-RestMethod https://raw.githubusercontent.com/obsproject/obs-websocket/master/docs/generated/protocol.json

# This will save us lots of time and effort for parsing


# We'll want to translate OBS WebSocket requests into commands.

# We'll want a prefix on all commands.
$modulePrefix = 'OBS'
# And we'll want a hashtable of replacements

# A number of request types start with a verb name already
$verbReplacements = @{}
# these are easy
foreach ($easyVerb in 'Get', 'Set','Open', 'Close', 'Start', 'Stop', 'Resume','Remove','Save','Send') {
    $verbReplacements[$easyVerb] = $easyVerb
}
# A number of other words cases should also infer the verb
$verbReplacements += [Ordered]@{    
    'Toggle'      = 'Switch' # Toggle infers switch
    'Create'      = 'Add'    # Create infers add
    'Duplicate'   = 'Copy'   # Duplicate infers copy
    'Broadcast'   = 'Send'   # Broadcast infers Send
    'List'        = 'Get'    # List infers get (but may cause duplication problems)
}

# Construct a pair of regex to see if something starts or ends with our replacements
$startsWithVerbRegex = "^(?>$($verbReplacements.Keys -join '|'))"
$endsWithVerbRegex   = "(?>$($verbReplacements.Keys -join '|'))$"

# We also want a pair of regexes to determine if a value has a min/max range.
$minRangeRestriction = "\>=\s{0,}(?<min>[\d\.-]+)"
$maxRangeRestriction = "\<=\s{0,}(?<max>[\d\.-]+)"

# Create an array to hold all of the functions we create
$obsFunctions = @()
# and files we build.
$filesBuilt   = @()

# And determine where we want to store them
$commandsPath = Join-Path $PSScriptRoot Commands
$requestsPath = Join-Path $commandsPath Requests

# (create the directory if it didn't already exist)
if (-not (Test-Path $requestsPath)) {
    $null = New-Item -ItemType Directory -Path $requestsPath -Force
}

# Declare the process block for all commands now
$obsFunctionProcessBlock = {

        # Create a copy of the parameters (that are part of the payload)
        $paramCopy = [Ordered]@{}
        # get a reference to this command
        $myCmd = $MyInvocation.MyCommand

        # Keep track of how many requests we have done of a given type
        # (this makes creating RequestIDs easy)
        if (-not $script:ObsRequestsCounts) {
            $script:ObsRequestsCounts = @{}
        }

        # Set my requestType to blank
        $myRequestType = ''
        # and indicate we are not expecting a response
        $responseExpected = $false
        # Then walk over this commands' attributes,
        foreach ($attr in $myCmd.ScriptBlock.Attributes) {
            if ($attr -is [Reflection.AssemblyMetadataAttribute]) {
                if ($attr.Key -eq 'OBS.WebSocket.RequestType') {
                    $myRequestType = $attr.Value # set the requestType,
                }
                elseif ($attr.Key -eq 'OBS.WebSocket.ExpectingResponse') {
                    # and determine if we are expecting a response.
                    $responseExpected = 
                        if ($attr.Value -eq 'false') {
                            $false   
                        } else { $true }
                }
            }
        }

        # Walk over each parameter
        :nextParam foreach ($keyValue in $PSBoundParameters.GetEnumerator()) {
            # and walk over each of it's attributes to see if it part of the payload
            foreach ($attr in $myCmd.Parameters[$keyValue.Key].Attributes) {
                # If the parameter is bound to part of the payload
                if ($attr -is [ComponentModel.DefaultBindingPropertyAttribute]) {
                    # copy it into our payload dicitionary.
                    $paramCopy[$attr.Name] = $keyValue.Value
                    # (don't forget to turn switches into booleans)
                    if ($paramCopy[$attr.Name] -is [switch]) {
                        $paramCopy[$attr.Name] = [bool]$paramCopy[$attr.Name]
                    }
                    continue nextParam
                }
            }
        }

        # If we don't have a request counter for this request type
        if (-not $script:ObsRequestsCounts[$requestType]) {
            # initialize it to zero.
            $script:ObsRequestsCounts[$requestType] = 0
        }
        # Increment the counter for requests of this type
        $script:ObsRequestsCounts[$requestType]++

        # and make a request ID from that.
        $myRequestId = "$myRequestType.$($script:ObsRequestsCounts[$requestType])"

        # Construct the actual payload
        $payloadJson = [Ordered]@{
            op = 6   # All requests are sent with the opcode 6
            d = @{
                # and must include a request ID
                requestId = "$myRequestType.$($script:ObsRequestsCounts[$requestType])"
                # request type
                requestType = $myRequestType
                # and optional data
                requestData = $paramCopy
            }
        } |
            # Once we have constructed the payload, make it JSON
            ConvertTo-Json -Depth 100
        
        # And create a byte segment to send it offf.
        $SendSegment  = [ArraySegment[Byte]]::new([Text.Encoding]::UTF8.GetBytes($PayloadJson))

        # If we have no OBS connections
        if (-not $script:ObsConnections.Values) {
            # error out
            Write-Error "Not connected to OBS.  Use Connect-OBS."
            return
        }

        # Otherwise, walk over each connection
        foreach ($obsConnection in $script:ObsConnections.Values) {
            $OBSWebSocket = $obsConnection.Websocket
            if ($VerbosePreference -notin 'silentlyContinue', 'ignore') {
                Write-Verbose "Sending $payloadJSON"
            }
            # and send the payload
            $null = $OBSWebSocket.SendAsync($SendSegment,'Text', $true, [Threading.CancellationToken]::new($false))

            # If a response was expected
            if ($responseExpected) {
                # wait a second for that event
                $eventResponse = Wait-Event -SourceIdentifier $myRequestId -Timeout 1 |
                    Select-Object -ExpandProperty MessageData

                if ($eventResponse -is [Management.Automation.ErrorRecord]) {
                    Write-Error -ErrorRecord $eventResponse
                    continue
                }
                # Collect all properties from the response
                $eventResponseProperties = @($eventResponse.psobject.properties)
                
                $expandedResponse =
                    # If there was only one, expand that property
                    if ($eventResponseProperties.Length -eq 1) {
                        $eventResponse.psobject.properties.value
                    } else {
                        $eventResponse
                    }

                
                # Now walk thru each response and expand / decorate it
                foreach ($responseObject in $expandedResponse) {
                    # If there was no response, move on.
                    if ($null -eq $responseObject) {
                        continue
                    }
                    # If the response is a string and it's the same as the request type                        
                    if ($responseObject -is [string] -and $responseObject -eq $myRequestType) {
                        continue # ignore it
                    }
                    # otherwise, if the response looks like a file
                    elseif ($responseObject -is [string] -and 
                        $responseObject -match '^(?:\p{L}\:){0,1}[\\/]') {
                        $fileName = $responseObject -replace '[\\/]', ([io.path]::DirectorySeparatorChar)
                        if (Test-Path $fileName) {
                            $responseObject = Get-Item -LiteralPath $fileName
                        }
                    }

                    # Otherwise, create a new PSObject out of the response
                    $responseObject = [PSObject]::new($responseObject)                    
                    # and decorate it with the command name and OBS.requestype.response
                    $responseObject.pstypenames.add("$myCmd")                        
                    $responseObject.pstypenames.add("OBS.$myRequestType.Response")

                    # Now, walk thru all properties in our input payload
                    foreach ($keyValue in $paramCopy.GetEnumerator()) {
                        # If they were not in our output
                        if (-not $responseObject.psobject.properties[$keyValue.Key]) {
                            # add them
                            $responseObject.psobject.properties.add(
                                [psnoteproperty]::new($keyValue.Key, $keyValue.Value)
                            )
                        }

                        # Doing this will make it easier to pipe one step to another
                        # and make results more useful.
                    }

                    # finally, emit our response object
                    $responseObject
                }            
            }    
        }
}


# Walk over each type of request.
foreach ($obsRequestInfo in $obsWebSocketProtocol.requests) {   
    $requestType = $obsRequestInfo.RequestType
    $replacedRequestType = "$requestType"
    
    # Determine the function name
    $obsFunctionName =
        @(
        # If it started with something that inferred the verb
        if ($requestType -match $startsWithVerbRegex) {
            # replace the name
            $replacedRequestType = ($replacedRequestType -replace $startsWithVerbRegex)
            $verbReplacements[$matches.0] + '-' + $modulePrefix + $replacedRequestType
        }
        
        # If it ended with something that inferred the verb
        if ($requestType -cmatch $endsWithVerbRegex) {
            # replace the name again
            $replacedRequestType = ($replacedRequestType -creplace $endsWithVerbRegex)
            $verbReplacements[$matches.0] + '-' + $modulePrefix + $replacedRequestType
        }

        # If it didn't start or end with something that inferred a verb
        if ($requestType -notmatch $startsWithVerbRegex -and 
            $requestType -notmatch $endsWithVerbRegex) {
            # Use Send-
            "Send-${modulePrefix}${RequestType}"
        })[-1] # Pick the last output for from this set of options, as this will be the most changed.
    
    $obsFunctionParameters = [Ordered]@{}

    # Now we have to turn each field in the request into a parameter
    foreach ($requestField in $obsRequestInfo.requestFields) {
        $valueType = $requestField.valueType
        # Some field names contain periods, don't forget to get rid of those.
        $paramName = $requestField.valueName -replace '\.'

        $paramType = # map their parameter types to PowerShell parameter types
            if ($valueType -eq 'Boolean') { '[switch]'}
            elseif ($valueType -eq 'Number') { '[double]'}
            elseif ($valueType -eq 'Object') { '[PSObject]'}
            elseif ($valueType -eq 'Any') { '[PSObject]'}
            elseif ($valueType -eq 'String') { '[string]'}
            else { '' }
        
            # And declare a parameter
            $obsFunctionParameters[$paramName] = 
                @(                   
                    # Include the description 
                    "<# $($requestField.ValueDescription) #>"
                    # Make sure to declare it as ValueFromPipelineByPropertyName                    
                    "[Parameter($(
                        # and mark it as mandtory if it's not optional.
                        if (-not $requestField.ValueOptional) { "Mandatory,"}
                    )ValueFromPipelineByPropertyName)]"
                    # Track the 'bound' property
                    "[ComponentModel.DefaultBindingProperty('$($requestField.valueName)')]"
                    # If there were range descriptions
                    if ($requestField.valueRestrictions) {
                        # determine the min/max
                        $rangeMin, $rangeMax = $null, $null

                        if ($requestField.valueRestrictions -match $minRangeRestriction) {
                            $rangeMin = [double]$matches.min
                        }
                        if ($requestField.valueRestrictions -match $maxRangeRestriction) {
                            $rangeMax = [double]$matches.max
                        }

                        # and write a [ValidateRange()]
                        if ($rangeMin -ne $null -or $rangeMax -ne $null) {
                            "[ValidateRange($($rangeMin),$(if ($rangeMax) {
                                $rangeMax
                            } elseif ([Math]::Round($rangeMin) -eq $rangeMin) {
                                "[int]::MaxValue"
                            } else {
                                "[double]::MaxValue"
                            }))]"
                        }
                    }
                    # Include the parameter type
                    $paramType
                    # and declare the parameter.
                    "`$$paramName"
                )
    }
    
    $newFunc = 
    New-PipeScript -FunctionName $obsFunctionName -Parameter $obsFunctionParameters -Process $obsFunctionProcessBlock -Attribute @"
[Reflection.AssemblyMetadata('OBS.WebSocket.RequestType', '$requestType')]
$(
    if ($obsRequestInfo.responseFields.Count) {
"[Reflection.AssemblyMetadata('OBS.WebSocket.ExpectingResponse', `$true)]"
    }
)
"@ -Synopsis "
$obsFunctionName : $requestType
" -Description @"
$($obsRequestInfo.description)


$obsFunctionName calls the OBS WebSocket with a request of type $requestType.
"@ -Example @(
    if ($obsRequestInfo.requestFields.Count -eq 0) {
        "$obsFunctionName"
    }
) -Link @(
    "https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#$($requestType.ToLower())"
)

    
    # If no function was created, something went wrong
    if (-not $newFunc) {
        # so leave this no-op in here to be able to easily debug.
        $null = $null
    } else {
        # Otherwise, write the ful
        $outputPath = Join-Path $requestsPath "$obsFunctionName.ps1"
        $newFunc | Set-Content $outputPath -Encoding utf8
        $builtFile = Get-Item -LiteralPath $outputPath
        # and attach information about what was generated (in case of collision)
        $builtFile | 
            Add-Member NoteProperty OBSRequestType $obsRequestInfo.requestType -Force -PassThru |
            Add-Member NoteProperty OBSRequestInfo $obsRequestInfo -Force -PassThru |
            Add-Member NoteProperty Contents "$newFunc" -Force
        $filesBuilt += $builtFile
        $obsFunctions += $newFunc        
    }
}


# Now group all the files
$filesBuilt | 
    Group-Object |    
    ForEach-Object {
        # If it only created it once
        if ($_.Count -eq 1) {
            return $_.Group # return it directly
        }

        # Otherwise, basically do a simplified rename on each file
        $groupOfDuplicates = $_.Group
        $groupInfo = $_
        # start by removing our current name
        Remove-Item $groupOfDuplicates[0].FullName
        # Then, for each duplicate
        foreach  ($file in $groupOfDuplicates) {
            
            # Figure out the name it thought it had
            $functionName = $file.Name -replace '\.ps1$'

            # And the underlying request type
            $requestType = $file.OBSRequestType

            # use that to re-determine the function name
            $newFunctionName = 
                if ($requestType -match $startsWithVerbRegex) {                    
                    $verbReplacements[$matches.0] + '-' +
                        $modulePrefix + ($RequestType -replace $startsWithVerbRegex)
                } else {
                    "Send-${modulePrefix}${RequestType}"
                }

            # and use that name to determine a new path
            $newPath =  Join-Path $file.Directory "$newFunctionName.ps1"

            # Then replace the function name within it's contents.
            $file.contents -replace $functionName, $newFunctionName |
                Set-Content -LiteralPath $newPath -Encoding utf8

            # And return the new file, with the same information set attached.
            Get-Item -LiteralPath $newPath |
                Add-Member NoteProperty OBSRequestType $file.requestType -Force -PassThru |
                Add-Member NoteProperty OBSRequestInfo $file.obsRequestInfo -Force -PassThru |
                Add-Member NoteProperty Contents $file.Contents -Force -PassThru
        }
    }