<#
.SYNOPSIS
    Generates obs-powershell commands for PixelShaders
.DESCRIPTION

#>

if ($env:GITHUB_STEP_SUMMARY) {
@"
### Shader build
"@ | Out-File -Path $env:GITHUB_STEP_SUMMARY -Append
}

#region Sparse cloning https://github.com/Exeldro/obs-shaderfilter.git
$CloneAndGetShaders = {
    @(
        $cloneArgs = @("--sparse","--no-checkout","--filter=tree:0", "https://github.com/Exeldro/obs-shaderfilter.git")
        $cloneOut = git clone @cloneArgs *>&1
        Push-Location (Join-Path $pwd "obs-shaderfilter")
        git sparse-checkout set --no-cone '**.shader' '**.effect'
        $checkoutOut = git checkout
        Get-ChildItem -Recurse -File | Where-Object { $_.Directory.Name -notin 'internal' }
        Pop-Location
    )    
}

if ($env:GITHUB_STEP_SUMMARY) {
    "* Cloning Shaders with:
~~~PowerShell
$CloneAndGetShaders
~~~
" | Out-File -Path $env:GITHUB_STEP_SUMMARY -Append
}

$SparselyClonedShaders = . $CloneAndGetShaders
#endregion Sparse cloning https://github.com/Exeldro/obs-shaderfilter.git

$parentPath = $PSScriptRoot | Split-Path

$ShaderFiles = $SparselyClonedShaders

if ($env:GITHUB_STEP_SUMMARY) {
"* [x] Found $($shaderFiles.Length) Shaders to Build" |
    Out-File -Path $env:GITHUB_STEP_SUMMARY -Append
}    


$commandsPath = Join-Path $parentPath Commands
$ShaderCommandsPath = Join-Path $commandsPath Shaders

if (-not (Test-Path $ShaderCommandsPath))  {
    $null = New-Item -ItemType Directory -path $ShaderCommandsPath
}

$FindShaderParameters = '[^/]{0,}uniform\s{1,}(?<Type>\S+)\s{1,}(?<ParameterName>[\S-[\<\;]]+)'

$AllShaderParameters = $ShaderFiles | 
    Select-String $FindShaderParameters |
    Where-Object { "$_" -notlike "*//*"}
$ShaderParameters = $AllShaderParameters |
        Group-Object Path

if ($env:GITHUB_STEP_SUMMARY) {
    "* [x] Found $($AllShaderParameters.Length) Shader Parameters in $($ShaderParameters.Count) files" |
        Out-File -Path $env:GITHUB_STEP_SUMMARY -Append
}

$importedModule = Import-Module $parentPath -Global -PassThru

if (-not $importedModule) {
    if ($env:GITHUB_STEP_SUMMARY) {
@"
**Could Not Import Module from $parentPath**
"@ | Out-File -Path $env:GITHUB_STEP_SUMMARY -Append
    }
        
    Write-Error "Could not import module"
    return
}


$underscoreWord  = "[\w-[_]]+_?"
$capitalizeNames = {
    param($match)
    $matchAsString = "$match"
    $matchAsString.Substring(0,1).ToUpper() + $matchAsString.Substring(1) -replace "_"
}

$FindAnnotations = [Regex]::new("$FindShaderParameters\<[\s\S]+?>",'IgnoreCase')
$generatingJobs  = @()

foreach ($shaderParameterSet in $ShaderParameters) {
    $shaderFileName = @($shaderParameterSet.Name.Split([IO.Path]::DirectorySeparatorChar))[-1]
    $shaderName = $shaderFileName -replace '\.(?>effect|shader)$'
    $ShaderNoun = "OBS" + ([Regex]::Replace($shaderName, $underscoreWord,$capitalizeNames) -replace '[\p{P}_\+]') + "Shader"
    if ($env:GITHUB_STEP_SUMMARY) {
        "  * [x] Generating Shader from $shaderFileName ( $ShaderNoun )" |
            Out-File -Path $env:GITHUB_STEP_SUMMARY -Append
    }
    $ShaderContent = [IO.File]::ReadAllText($shaderParameterSet.Name)
    $ShaderAnnotations = [Ordered]@{}
    $foundShaderAnnotations = @($FindAnnotations.Matches($ShaderContent))
    if ($env:GITHUB_STEP_SUMMARY) {
        "  * [x] Found $($foundShaderAnnotations.Length) Shader annotations in $shaderFileName ( $ShaderNoun )" |
            Out-File -Path $env:GITHUB_STEP_SUMMARY -Append
    }
    foreach ($shaderAnnotation in $FindAnnotations.Matches($ShaderContent)) {
        $null = $shaderAnnotation -match $FindAnnotations        
        $shaderAnnotations[$matches.'ParameterName'] = [Ordered]@{} + $matches
    }

    $ShaderParameters = [Ordered]@{}
    
    if ($env:GITHUB_STEP_SUMMARY) {
        "  * [x] Found $(@($shaderParameterSet.Group).Length) Shader Parameters in $($shaderName)" |
            Out-File -Path $env:GITHUB_STEP_SUMMARY -Append
    }

    foreach ($shaderParameterInSet in $shaderParameterSet.Group) {        
        $shaderMatch = "$(@("$($shaderParameterInSet)") -join '')" -match $FindShaderParameters
        $shaderMatch = [Ordered]@{} + $matches
        $shaderParameterSystemName = $shaderMatch.ParameterName

        if ($shaderParameterSystemName -match '[^\w_]') {
            if ($env:GITHUB_STEP_SUMMARY) {
                "    * [ ] Shader Parameter $shaderParameterSystemName will be skipped due to improper naming" |
                    Out-File -Path $env:GITHUB_STEP_SUMMARY -Append
            }
            continue
        }
        # Shader parameters can conflict with automatic parameters (we can sidestep this with a rename)
        $shaderParameterName = 
            switch ($shaderParameterSystemName) {
                debug {
                    "DebugShader"
                }
                default {
                    [Regex]::Replace($shaderParameterSystemName, $underscoreWord,$capitalizeNames)
                }        
            }
        
        if ($env:GITHUB_STEP_SUMMARY) {
            "    * [x] Shader Parameter $shaderParameterSystemName will become $ShaderParameterName" |
                Out-File -Path $env:GITHUB_STEP_SUMMARY -Append
        }

        $ShaderParameterHelp = "Set the $shaderParameterSystemName of $ShaderNoun"
        $ShaderParameterAttributes = @()

        # If there were annotations, pick them out.
        if ($shaderParameterInSet -like '*<') {            
            $annotationsForThisShader = $ShaderAnnotations[$shaderParameterSystemName]
            $annotationList = 
                $ShaderAnnotations[$shaderParameterSystemName].0 -split '[\<\>\;]' -notmatch '^\s{0,}$' | 
                Select-Object -Skip 1
            
            $ShaderMin, $ShaderMax = $null, $null

            foreach ($annotationItem in $annotationList) {
                $annotationItems = @($annotationItem -split '\s+' -ne '')
                $afterEquals = @($annotationItems | Select-Object -Skip 3) -join ' ' -replace '"'                        
                switch ($annotationItems[1]) {
                    label { 
                        $null = $null
                        $ShaderParameterHelp = $afterEquals
                    }
                    maximum {
                        $null = $null
                        $ShaderMax = $afterEquals -as [float]
                    }
                    minumum {
                        $ShaderMin = $afterEquals -as [float]
                    }
                }
            }

            if ($null -ne $ShaderMax -and $null -ne $ShaderMin) {
                $ShaderParameterAttributes += "[ValidateRange($ShaderMin, $ShaderMax)]"
            }
        }


        $shaderParameterType = $shaderMatch.Type
        
        $ShaderPowerShellParameterType = 
            switch ($shaderParameterType) {
                int { [int] }
                bool { [switch] }

                string { [string] }
                texture2d { [string] }
                
                float { [float] }                
                float2 { [float[]] }
                float3 { [float[]] }
                float4 { [string] <# float4 is usually a color #>}
                float4x4 { [float[][]]}

                default {                    
                    [PSObject]
                }
            }

        $ShaderParameters[$shaderParameterName] = [Ordered]@{
            ParameterName  = $shaderParameterName
            ParameterType  = $ShaderPowerShellParameterType
            Attribute = "[ComponentModel.DefaultBindingProperty('$ShaderParameterSystemName')]"
            Help = $ShaderParameterHelp                        
        }
        
        if ($shaderParameterSystemName -ne $shaderParameterName -and $shaderParameterSystemName -notin 'debug') {
            $ShaderParameters[$shaderParameterName].Alias = $shaderParameterSystemName
        }
    }

    $ShaderParameters["SourceName"] = [Ordered]@{
        Attribute = 'ValueFromPipelineByPropertyName'
        Alias = 'SceneItemName'
        ParameterType = [string]
        Help = "The name of the source.  This must be provided when adding an item for the first time"
    }
    
    $ShaderParameters["FilterName"] = [Ordered]@{
        Attribute = 'ValueFromPipelineByPropertyName'
        ParameterType = [string]
        Help = "The name of the filter.  If this is not provided, this will default to the shader name."
    }

    $ShaderParameters["ShaderText"] = [Ordered]@{
        ParameterName = "ShaderText"
        ParameterType = [string]
        Alias = "ShaderContent"
        Help = "The inline value of the shader.  This will normally be provided as a default parameter, based off of the name."    
    }

    $ShaderParameters["PassThru"] = [Ordered]@{
        ParameterName = "PassThru"
        ParameterType = [switch]        
        Help = "If set, will pass thru the commands that would be sent to OBS (these can be sent at any time with Send-OBS)"            
    }

    $ShaderParameters["NoResponse"] = [Ordered]@{
        ParameterName = "NoResponse"
        ParameterType = [switch]        
        Help = "If set, will not wait for a response from OBS (this will be faster, but will not return anything)"
    }


    $ShaderProcess = [scriptblock]::Create(@"
`$shaderName = '$shaderName'
`$ShaderNoun = '$ShaderNoun'
if (-not `$psBoundParameters['ShaderText']) {    
    `$psBoundParameters['ShaderText'] = `$ShaderText = '
$($ShaderContent -replace "'","''")
'
}
"@ + {
$MyVerb, $myNoun = $MyInvocation.InvocationName -split '-',2
if (-not $myNoun) {
    $myNoun = $myVerb
    $myVerb = 'Get'    
}
switch -regex ($myVerb) {
    Get {
        $FilterNamePattern = "(?>$(
            if ($FilterName) {
                [Regex]::Escape($FilterName)
            }
            else {
                [Regex]::Escape($ShaderNoun -replace '^OBS' -replace 'Shader$'),[Regex]::Escape($shaderName) -join '|'
            }
        ))"
        if ($SourceName) {
            Get-OBSInput | 
                Where-Object InputName -eq $SourceName |
                Get-OBSSourceFilterList |
                Where-Object FilterName -Match $FilterNamePattern
        } else {
            $obs.Inputs |
                Get-OBSSourceFilterList |
                Where-Object FilterName -Match $FilterNamePattern
        }        
    }
    '(?>Add|Set)' {
        $ShaderSettings = [Ordered]@{}
        :nextParameter foreach ($parameterMetadata in $MyInvocation.MyCommand.Parameters[@($psBoundParameters.Keys)]) {
            foreach ($parameterAttribute in $parameterMetadata.Attributes) {
                if ($parameterAttribute -isnot [ComponentModel.DefaultBindingPropertyAttribute]) { continue }
                $ShaderSettings[$parameterAttribute.Name] = $PSBoundParameters[$parameterMetadata.Name]
                continue nextParameter
            }            
        }

        if (-not $PSBoundParameters['FilterName']) {
            $filterName = $PSBoundParameters['FilterName'] = $shaderName
        }

        $ShaderFilterSplat = [Ordered]@{
            ShaderSetting = $ShaderSettings
            FilterName = $FilterName
            SourceName = $SourceName
        }

        foreach ($CarryOnParameter in "PassThru", "NoResponse","Force") {
            if ($PSBoundParameters.ContainsKey($CarryOnParameter)) {
                $ShaderFilterSplat[$CarryOnParameter] = $PSBoundParameters[$CarryOnParameter]
            }
        }

        if ($myVerb -eq 'Add') {
            $ShaderFilterSplat.ShaderText = $shaderText
            Add-OBSShaderFilter @ShaderFilterSplat
        } else {
            Set-OBSShaderFilter @ShaderFilterSplat
        }
    }
}
})
    
    

    $NewPipeScriptSplat = [Ordered]@{}
    $NewPipeScriptSplat.FunctionName = "Get-$ShaderNoun"
    $NewPipeScriptSplat.Parameter = $ShaderParameters
    $NewPipeScriptSplat.Alias = "Set-$ShaderNoun", "Add-$ShaderNoun"
    $NewPipeScriptSplat.OutputPath = (Join-Path $ShaderCommandsPath "Get-$ShaderNoun.ps1")
    $NewPipeScriptSplat.Process = $ShaderProcess
    <#
    $generatingJobs += Start-ThreadJob -ScriptBlock {
        param($PipeScriptPath, $NewPipeScriptSplat)

        Import-Module $pipeScriptPath
        New-PipeScript @NewPipeScriptSplat
    } -ArgumentList "$(Get-Module PipeScript | Split-Path | Join-Path -ChildPath PipeScript.psd1)",
        $NewPipeScriptSplat
    #>
    New-PipeScript @NewPipeScriptSplat
    <#$generatedFunction = New-PipeScript -FunctionName "Get-$ShaderNoun" -Parameter $ShaderParameters -Alias "Set-$ShaderNoun", 
        "Add-$ShaderNoun" -outputPath (Join-Path $ShaderCommandsPath "Get-$ShaderNoun.ps1") -Process $ShaderProcess
    $generatedFunction
    $null = $null      #>
}

<#
do {
    $generatingJobs | Receive-Job
    $generatingJobStates = @($generatingJobs | Select-Object -ExpandProperty State -Unique | Sort-Object) 
    Start-Sleep -Seconds 1
} while (($generatingJobStates -match '(?>NotStarted|Running)'))
#>

trap [Exception] {
if ($env:GITHUB_STEP_SUMMARY) {
@"
❗❗ Trapped Error!

ShaderName: ``$ShaderName``
~~~
$($_ | Out-String)
~~~
"@ | Out-File -Path $env:GITHUB_STEP_SUMMARY -Append
}        
    continue
}