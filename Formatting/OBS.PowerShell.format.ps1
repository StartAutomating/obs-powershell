Write-FormatView -TypeName OBS.PowerShell -Action {
    Write-FormatViewExpression -ForegroundColor "Success" -ScriptBlock {
        "obs-powershell@$($_.OBSPowerShellVersion)"
    }    
    Write-FormatViewExpression -ForegroundColor Verbose -ScriptBlock {
        "  Script your streaming."
    }
    Write-FormatViewExpression -Newline

    Write-FormatViewExpression -ScriptBlock {
        @(
            ""
            "   Everything in PowerShell is an object, and every object can be extended."
            ""
            "   See what this object can do:"
            ""
            "    Get-OBS | Get-Member"
            ""
        ) -join [Environment]::NewLine
    }

    Write-FormatViewExpression -ForegroundColor Verbose -ScriptBlock {
        @(
            ""
            "This object can be viewed in different ways:"
            ""

            foreach ($view in (Get-FormatData -TypeName OBS.PowerShell).FormatViewDefinition) {
                "    Get-OBS | Format-$($view.Control.GetType().Name -replace 'Control$') -View $($view.Name)"
            }
        ) -join [Environment]::NewLine
    }
} -Name 'Default'

Write-FormatView -TypeName "OBS.PowerShell" -Name 'Version' -Property OBSVersion, OBSWebSocketVersion, OBSPowerShellVersion -AutoSize -AlignProperty @{
    OBSVersion = "Center"
    OBSWebSocketVersion = "Center"
    OBSPowerShellVersion = "Center"
}

Write-FormatView -TypeName "OBS.PowerShell" -Name 'Version' -Property OBSVersion, OBSWebSocketVersion, OBSPowerShellVersion -AsList

Write-FormatView -TypeName "OBS.PowerShell" -Name 'Inputs' -Property Inputs -Wrap -VirtualProperty @{
    Inputs = {$_.Inputs.InputName -join [Environment]::NewLine}    
}

Write-FormatView -TypeName "OBS.PowerShell" -Name 'Scenes' -Property Scenes -Wrap -VirtualProperty @{
    Scenes = {$_.Scenes.SceneName -join [Environment]::NewLine}    
}

Write-FormatView -TypeName "OBS.PowerShell" -Name 'Status' -Action {
    Write-FormatViewExpression -ScriptBlock {
        $recordStatus = $_.RecordStatus
        $streamStatus = $_.StreamStatus
        $virtualCameraStatus = $_.VirtualCameraStatus
        @(
            @(if ($recordStatus.OutputActive) {
                if ($recordStatus.Paused) {
                    Format-RichText -ForegroundColor Warning -InputObject "Recording Paused" 
                } else {
                    Format-RichText -ForegroundColor Error -InputObject "Recording" 
                }            
            } else {
                Format-RichText -ForegroundColor Success -InputObject "Not Recording" 
            }
            if ($recordStatus.OutputDuration) {
                Format-RichText -ForegroundColor Cyan -InputObject $recordStatus.OutputTimecode            
            }) -join ' '

            @(if ($streamStatus.OutputActive) {
                if ($streamStatus.Paused) {
                    Format-RichText -ForegroundColor Warning -InputObject "Streaming Paused" 
                } else {
                    Format-RichText -ForegroundColor Error -InputObject "Streaming" 
                }            
            } else {
                Format-RichText -ForegroundColor Success -InputObject "Not Streaming" 
            }
            if ($streamStatus.OutputDuration) {
                Format-RichText -ForegroundColor Cyan -InputObject $streamStatus.OutputTimecode
            }) -join ' '

            
        ) -join [Environment]::Newline
    }
}
