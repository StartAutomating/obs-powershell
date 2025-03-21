---

title: obs powershell 0.2
sourceURL: https://github.com/StartAutomating/obs-powershell/releases/tag/v0.2
tag: release
---
> Like It? [Star It](https://github.com/StartAutomating/obs-powershell)
> Love It? [Support It](https://github.com/sponsors/StartAutomating)

## obs-powershell 0.2:

* So Many Shaders!
* @exeldro makes some excellent obs plugins
  * Every PixelShader from [obs-shaderfilter](https://github.com/exeldro/obs-shaderfilter) has an auto-generated function:
  * As of this build, there are 142 Shader functions!
  * Flip Shader ( [#200](https://github.com/StartAutomating/obs-powershell/issues/200) )
  * Zoom XY Shader ( [#199](https://github.com/StartAutomating/obs-powershell/issues/199) )
  * RGBA Percent Shader ( [#198](https://github.com/StartAutomating/obs-powershell/issues/198) )
  * Reflect Shader ( [#197](https://github.com/StartAutomating/obs-powershell/issues/197) )
  * Shader Commands now support -Force
* Drastically improved start time on Windows ([#214](https://github.com/StartAutomating/obs-powershell/issues/214))
* OBS Sources:
  * New Sources:
    * OBSSoundCloudSource ( [#179](https://github.com/StartAutomating/obs-powershell/issues/179) )
    * OBSSwitchSource ([#142](https://github.com/StartAutomating/obs-powershell/issues/142))
    * OBSMarkdownSource ([#143](https://github.com/StartAutomating/obs-powershell/issues/143))
    * OBSWaveformSource ([#141](https://github.com/StartAutomating/obs-powershell/issues/141))
  * All existing sources are now implemented in a `Get`, and aliased to `Set`,`Add`
    * Making Set also Get-OBSWindowSource ([#152](https://github.com/StartAutomating/obs-powershell/issues/152))
    * Making Set also Get-OBSVLCSource ([#151](https://github.com/StartAutomating/obs-powershell/issues/151))
    * Making Set also Get-OBSMediaSource ([#150](https://github.com/StartAutomating/obs-powershell/issues/150))
    * Making Set also Get-OBSColorSource ([#148](https://github.com/StartAutomating/obs-powershell/issues/148))
    * Making Set also Get-OBSBrowserSource ([#147](https://github.com/StartAutomating/obs-powershell/issues/147))
    * Making Set also Get-OBSAudioOutputSource ([#146](https://github.com/StartAutomating/obs-powershell/issues/146))
* New Effects:
  * Zoom In / Out Effect ( [#164](https://github.com/StartAutomating/obs-powershell/issues/164) )
  * Start-OBSEffect - Adding -Reverse (Fixes [#121](https://github.com/StartAutomating/obs-powershell/issues/121))
* Exporting `$obs` ([#157](https://github.com/StartAutomating/obs-powershell/issues/157), [#158](https://github.com/StartAutomating/obs-powershell/issues/158), [#159](https://github.com/StartAutomating/obs-powershell/issues/159)) and drastically expanding pseudo types
* Pseudo Types
  * GetCurrentProgramScene.ToString() ( Fixes [#202](https://github.com/StartAutomating/obs-powershell/issues/202), Fixes [#166](https://github.com/StartAutomating/obs-powershell/issues/166) )
  * OBS.Beat ( [#195](https://github.com/StartAutomating/obs-powershell/issues/195) )
    * OBS.Beat.Timer
    * OBS.Beat.TapBPM ( [#191](https://github.com/StartAutomating/obs-powershell/issues/191))
    * Stopping OBS.Beat.Timer on Unload
    * OBS.Beat.get_Sine ( [#192](https://github.com/StartAutomating/obs-powershell/issues/192) )
    * OBS.Beat.get_Cosine ( [#193](https://github.com/StartAutomating/obs-powershell/issues/193) )
    * OBS.Beat.Angle ( [#194](https://github.com/StartAutomating/obs-powershell/issues/194) )
    * OBS.Beat.Duration ( [#189](https://github.com/StartAutomating/obs-powershell/issues/189) )
    * OBS.Beat.BeatCount ( [#190](https://github.com/StartAutomating/obs-powershell/issues/190) )
    * OBS.Beat.BeatStart ( [#188](https://github.com/StartAutomating/obs-powershell/issues/188) )
    * OBS.Beat.BPM ( [#187](https://github.com/StartAutomating/obs-powershell/issues/187) )
    * $obs.Beat ( [#186](https://github.com/StartAutomating/obs-powershell/issues/186) )
  * OBS.Input
    * OBS.Input.Disable/EnableAllFilter(s) ( [#183](https://github.com/StartAutomating/obs-powershell/issues/183) )
    * OBS.SceneItem.Animate Permissiveness ( [#182](https://github.com/StartAutomating/obs-powershell/issues/182) )
    * OBS.Filter.Disable PassThru support ( [#181](https://github.com/StartAutomating/obs-powershell/issues/181) )
  * OBS.Statistics ( [#178](https://github.com/StartAutomating/obs-powershell/issues/178) )
  * OBS.Input ( [#174](https://github.com/StartAutomating/obs-powershell/issues/174) )
  * OBS.Filter ( [#175](https://github.com/StartAutomating/obs-powershell/issues/175) )
  * OBS.SceneItem ( [#173](https://github.com/StartAutomating/obs-powershell/issues/173) )
  * OBS.GetSceneItemList.Response.Stretch() ( [#172](https://github.com/StartAutomating/obs-powershell/issues/172) )
  * OBS.GetSceneItemList.Response.Center() ( [#171](https://github.com/StartAutomating/obs-powershell/issues/171) )
  * OBS.GetInputList .SourceName alias ( [#170](https://github.com/StartAutomating/obs-powershell/issues/170) )
  * Adding .SceneItem to OBS.Inputs (Fixes [#154](https://github.com/StartAutomating/obs-powershell/issues/154))
* Minor Fixes:
  * Watch-OBS -BufferSize: Defaulting to 64kb ( Fixes [#212](https://github.com/StartAutomating/obs-powershell/issues/212), Fixes [#213](https://github.com/StartAutomating/obs-powershell/issues/213) )
  * Fixing -Scene parameter defaults ( Fixes [#210](https://github.com/StartAutomating/obs-powershell/issues/210) )
  * Updating Build Conditions
  * obs-powershell now mounts itself ( [#180](https://github.com/StartAutomating/obs-powershell/issues/180) )
  * obs-powershell supporting module profiles ([#155](https://github.com/StartAutomating/obs-powershell/issues/155))

---

Previous release notes available in the [CHANGELOG](https://github.com/StartAutomating/obs-powershell/blob/main/CHANGELOG.md)
