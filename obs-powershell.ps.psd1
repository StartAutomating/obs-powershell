@{
    ModuleVersion     = '0.2.1'
    RootModule        = 'obs-powershell.psm1'
    Description       = 'Script your streams'
    Guid              = '1417123e-a932-439f-9b68-a7313cf1e170'
    Author            = 'James Brundage'
    CompanyName       = 'Start-Automating'
    Copyright         = '2022-2026 Start-Automating'
    FormatsToProcess  = 'obs-powershell.format.ps1xml'
    TypesToProcess    = 'obs-powershell.types.ps1xml'
    PowerShellVersion = '7.0'
    PrivateData = @{
        PSData = @{
            Tags = 'PowerShell', 'OBS'
            ProjectURI = 'https://github.com/StartAutomating/obs-powershell'
            LicenseURI = 'https://github.com/StartAutomating/obs-powershell/blob/main/LICENSE'
            ReleaseNotes = @'
## obs-powershell 0.2.1:

* New General Purpose Commands
  * Start-OBS (#220)
  * Stop-OBS (#226)
* New Shader Commands:
  * Get-OBS3dPanelShader
  * Get-OBSAudioShader
  * Get-OBSCubeRotatingShader
  * Get-OBSDisplacementMapAdvancedInvertShader
  * Get-OBSDisplacementMapAdvancedShader
  * Get-OBSDisplacementMapInvertShader
  * Get-OBSDisplacementMapShader
  * Get-OBSGlitchPeriodicShader
  * Get-OBSHardBlinkShader
  * Get-OBSMotionBlurShader
  * Get-OBSNoiseShader
  * Get-OBSNormalMapShader
  * Get-OBSPerspectiveShader
  * Get-OBSQuadrilateralCropShader
  * Get-OBSRepeatGridCenterCropShader
  * Get-OBSWalkingDeadPixelFixerShader
  * Get-OBSZoomBlurTransitionShader

---

> Like It? [Star It](https://github.com/StartAutomating/obs-powershell)
> Love It? [Support It](https://github.com/sponsors/StartAutomating)


Additional History available in the [CHANGELOG](https://github.com/StartAutomating/obs-powershell/blob/main/CHANGELOG.md)
'@
        }
    }
    FunctionsToExport = '' <#{
        $exportNames = Get-ChildItem -Recurse -Filter '*-*.ps1' |
            Where-Object Name -notmatch '\.[^\.]+\.ps1' |
            Foreach-Object { $_.Name.Substring(0, $_.Name.Length - $_.Extension.Length) }
        "'$($exportNames -join "',$([Environment]::Newline)'")'"
    }#>
}
