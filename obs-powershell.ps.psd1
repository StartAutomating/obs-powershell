@{
    ModuleVersion     = '0.2.0.1'
    RootModule        = 'obs-powershell.psm1'
    Description       = 'Script your streams'
    Guid              = '1417123e-a932-439f-9b68-a7313cf1e170'
    Author            = 'James Brundage'
    CompanyName       = 'Start-Automating'
    Copyright         = '2022-2023 Start-Automating'
    FormatsToProcess  = 'obs-powershell.format.ps1xml'
    TypesToProcess    = 'obs-powershell.types.ps1xml'
    PowerShellVersion = '7.0'
    PrivateData = @{
        PSData = @{
            Tags = 'PowerShell', 'OBS'
            ProjectURI = 'https://github.com/StartAutomating/obs-powershell'
            LicenseURI = 'https://github.com/StartAutomating/obs-powershell/blob/main/LICENSE'
            ReleaseNotes = @'
> Like It? [Star It](https://github.com/StartAutomating/obs-powershell)
> Love It? [Support It](https://github.com/sponsors/StartAutomating)

## obs-powershell 0.2.0.1:

* Fixing `Watch-OBS` (Fixes #216)
* Adding `CONTRIBUTING.md` (Fixes #204)
* Adding `CODE_OF_CONDUCT.md` (Fixes #205)

---

## obs-powershell 0.2:

* So Many Shaders!
* @exeldro makes some excellent obs plugins
  * Every PixelShader from [obs-shaderfilter](https://github.com/exeldro/obs-shaderfilter) has an auto-generated function:
  * As of this build, there are 142 Shader functions!
  * Flip Shader ( #200 )
  * Zoom XY Shader ( #199 )
  * RGBA Percent Shader ( #198 )
  * Reflect Shader ( #197 )
  * Shader Commands now support -Force
* Drastically improved start time on Windows (#214)
* OBS Sources:
  * New Sources:
    * OBSSoundCloudSource ( #179 )
    * OBSSwitchSource (#142)
    * OBSMarkdownSource (#143)
    * OBSWaveformSource (#141)
  * All existing sources are now implemented in a `Get`, and aliased to `Set`,`Add`
    * Making Set also Get-OBSWindowSource (#152)
    * Making Set also Get-OBSVLCSource (#151)
    * Making Set also Get-OBSMediaSource (#150)
    * Making Set also Get-OBSColorSource (#148)
    * Making Set also Get-OBSBrowserSource (#147)
    * Making Set also Get-OBSAudioOutputSource (#146)
* New Effects:
  * Zoom In / Out Effect ( #164 )
  * Start-OBSEffect - Adding -Reverse (Fixes #121)
* Exporting `$obs` (#157, #158, #159) and drastically expanding pseudo types
* Pseudo Types
  * GetCurrentProgramScene.ToString() ( Fixes #202, Fixes #166 )
  * OBS.Beat ( #195 )
    * OBS.Beat.Timer
    * OBS.Beat.TapBPM ( #191)
    * Stopping OBS.Beat.Timer on Unload
    * OBS.Beat.get_Sine ( #192 )
    * OBS.Beat.get_Cosine ( #193 )
    * OBS.Beat.Angle ( #194 )
    * OBS.Beat.Duration ( #189 )
    * OBS.Beat.BeatCount ( #190 )
    * OBS.Beat.BeatStart ( #188 )
    * OBS.Beat.BPM ( #187 )
    * $obs.Beat ( #186 )
  * OBS.Input
    * OBS.Input.Disable/EnableAllFilter(s) ( #183 )
    * OBS.SceneItem.Animate Permissiveness ( #182 )
    * OBS.Filter.Disable PassThru support ( #181 )
  * OBS.Statistics ( #178 )
  * OBS.Input ( #174 )
  * OBS.Filter ( #175 )
  * OBS.SceneItem ( #173 )
  * OBS.GetSceneItemList.Response.Stretch() ( #172 )
  * OBS.GetSceneItemList.Response.Center() ( #171 )
  * OBS.GetInputList .SourceName alias ( #170 )
  * Adding .SceneItem to OBS.Inputs (Fixes #154)
* Minor Fixes:
  * Watch-OBS -BufferSize: Defaulting to 64kb ( Fixes #212, Fixes #213 )
  * Fixing -Scene parameter defaults ( Fixes #210 )
  * Updating Build Conditions
  * obs-powershell now mounts itself ( #180 )
  * obs-powershell supporting module profiles (#155)

---

Previous release notes available in the [CHANGELOG](https://github.com/StartAutomating/obs-powershell/blob/main/CHANGELOG.md)
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
