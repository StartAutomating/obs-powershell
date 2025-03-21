function Import-OBSEffect {

    <#
    .SYNOPSIS
        Imports Effects
    .DESCRIPTION
        Imports obs-powershell effects        
    .EXAMPLE
        Import-OBSEffect -Path (Get-Module obs-powershell)
    .LINK
        Get-OBSEffect
    #>
    param(
    # The source location of the effect.
    # This can be a string, file, directory, command, or module.
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
    [Alias(        
        'FromPath',
        'FromModule',
        'FromScript',
        'FromFunction',
        'FullName',
        'Path',
        'Source'
    )]    
    [ValidateScript({
    $validTypeList = [System.String],[System.IO.FileInfo],[System.IO.DirectoryInfo],[System.Management.Automation.CommandInfo],[System.Management.Automation.PSModuleInfo]
    
    $thisType = $_.GetType()
    $IsTypeOk =
        $(@( foreach ($validType in $validTypeList) {
            if ($_ -as $validType) {
                $true;break
            }
        }))
    
    if (-not $isTypeOk) {
        throw "Unexpected type '$(@($thisType)[0])'.  Must be 'string','System.IO.FileInfo','System.IO.DirectoryInfo','System.Management.Automation.CommandInfo','psmoduleinfo'."
    }
    return $true
    })]
    
    $From
    )

    begin {        
        if (-not $script:OBSFX) {
            $script:OBSFX = [Ordered]@{}
        }

        $newEffects = @()
        $obsEffectsPattern = [Regex]::new('
        (?>
            ^OBS.(?>fx|effects?)\p{P}
            |
            [\p{P}-[-]]OBS\.(?>fx|effects?)$
            |
            \p{P}OBS.(?>fx|effects?)\.(?>ps1|json)$
        )
        ','IgnoreCase,IgnorePatternWhitespace')
    }

    process {
        # Since -From can be many things, but a metric has to be a command,
        # the purpose of this function is to essentially resolve many things to a command, 
        # and then cache that command.

        # If -From was a string
        if ($From -is [string]) {
            # It could be a module, so check those first.            
            :ResolveFromString do {
                foreach ($loadedModule in @(Get-Module)) {
                    # If we find the module, don't try to resolve -From as a path
                    if ($loadedModule.Name -eq $from) { 
                                # (just set -From again and let the function continue)
                                                $from = $fromModule = $loadedModule;break ResolveFromString                        
                            }
                        
                }
                # If we think from was a path
                $resolvedPath = $ExecutionContext.SessionState.Path.GetResolvedPSPathFromPSPath($from)
                # attempt to resolve it
                if ($resolvedPath) {
                    $from = Get-Item -LiteralPath $resolvedPath
                }
            } while ($false)
        }

        # If -From is a module
        if ($from -is [Management.Automation.PSModuleInfo]) {
            # recursively call ourselves with all matching commands
            @($from.ExportedCommands.Values) -match $obsEffectsPattern |
                Import-OBSEffect
            # then, make -From a directory
            if ($from.Path) {
                $from = Get-Item ($from.Path | Split-Path) -ErrorAction SilentlyContinue
            }
        }
        
        # If -From is a directory
        if ($from -is [IO.DirectoryInfo]) {
            $FromDirectory = $from
            # recursively call ourselves with all matching scripts
            Get-ChildItem -LiteralPath $from.FullName -Recurse -File | 
                Where-Object Name -match '\.obs\.(?>fx|effects?).(?>ps1|json)$' |
                Import-OBSEffect
            return
        }

        # If -From is a file
        if ($from -is [IO.FileInfo]) {
            # and it matches the naming convention
            if ($from.Name -notmatch '\.obs\.(?>fx|effects?).(?>ps1|json)$') { return }
            # make -From a command.
            $from = $ExecutionContext.SessionState.InvokeCommand.GetCommand($from.FullName, 'ExternalScript,Application')
        }

        # If -From is a command
        if ($from -is [Management.Automation.CommandInfo]) {
            # decorate the command
            if ($from.pstypenames -notcontains 'OBS.PowerShell.Effect') {
                $from.pstypenames.insert(0,'OBS.PowerShell.Effect')                
            }

            if ($from -is [Management.Automation.ApplicationInfo]) {
                $effectName = $from.Name -replace '\.obs\.(?>fx|effects?).(?>ps1|json)$'
                $newEffect  = [PSCustomObject][Ordered]@{
                    PSTypeName = 'OBS.PowerShell.Effect'
                    Messages   = Get-Content -Raw -Path $From.Source | ConvertFrom-Json
                    EffectName = $effectName
                    TypeName   = $TypeName
                }
                $script:OBSFX[$effectName] = $newEffect
                $newEffects += $newEffect
                $newEffect
            } else {
                if ($from.pstypenames -notcontains 'OBS.PowerShell.Effect.Command') {
                    $from.pstypenames.insert(0,'OBS.PowerShell.Effect.Command')                
                }
                # and add it to our list of new metrics
                $newEffects+= $from
                $script:OBSFX[$from.EffectName] = $from
                $from
            }                    
        }                
    }



}

