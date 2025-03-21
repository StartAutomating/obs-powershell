> Like It? [Star It](https://github.com/StartAutomating/obs-powershell)
> Love It? [Support It](https://github.com/sponsors/StartAutomating)

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

## obs-powershell 0.1.9:

* New Filters!
  * @exeldro makes some excellent obs plugins
  * obs-powershell now supports a couple of them:
  * Set-OBS3DFilter (#137) - Transform an object in 3D!
  * Set-OBSShaderFilter (#134) - Apply _any_ PixelShader!
* New Effects!
  * LeftToRight (#125) / RightToLeft (#126)
  * TopToBottom (#127) / BottomToTop (#128)
  * ZoomIn (#129) / ZoomOut (#130)
* Effect Fixes
  * Start-OBSEffect - Adding -LoopCount (#133)
  * FadeIn/FadeOut no longer conflict (#119) (thanks @I-Am-Jakoby)!

---

## obs-powershell 0.1.8:

* Added Sponsorship, Please support obs-powershell (#78)
* Added OBS-PowerShell Effects (#109)
  * Effect Commands
    * Get-OBSEffect
    * Import-OBSEffect
    * Start-OBSEffect
    * Stop-OBSEffect
    * Remove-OBSEffect
  * ColorLoop (#113)
  * FadeIn (#112)
  * FadeOut (#114) (thanks @I-Am-Jakoby !)  
* Adding Commands for Filtering  
  * Set/Add-OBSGainFilter (#94) 
  * Set/Add-OBSColorFilter (#92)
  * Set/Add-OBSScrollFilter (#93)
  * Set/Add-OBSSharpnessFilter (#95)
  * Set/Add-OBSRenderDelayFilter (#96)
  * Set/Add-OBSEqualizerFilter (#97)
* New Easy Sources
  * Set/Add-OBSAudioOutputSource (#110)
  * Set/Add-OBSWindowSource (#104)
  * Set/Add-OBSVLCSource (#102)
* Scene Items Can Now Do A Lot More
  * Animate allows for multiple steps and is more careful (#75 and #73)
  * Move, Scale, Rotate are written using animate (#80, #81, #89)
* Extending Inputs (#99)
* Autogenerating help for extended types, thanks to a new version of [HelpOut](https://github.com/StartAutomating/HelpOut)
* Improving Performance and Stability of Send/Receive/Watch-OBS (#77, #90, #86, #106, #107)


* Also, new logo (#76)

---

## obs-powershell 0.1.7:

* New Commands:
  * Show-OBS (Fixes #66)
  * Hide-OBS (Fixes #67)
  * Remove-OBS (Fixes #68)

* Adding -Force to Add-OBS*Source commands (Fixes #69)
* Add-OBS*Source Commands:  Supporting -SceneItemEnabled (Fixes #70)
* Add-OBSMediaSource, adding -FitToScreen (Fixes #71)

---

## obs-powershell 0.1.6:

* Adding OBS.SceneItem .Scale (Fixes #64)
* OBS.SceneItem .FitToScreen, adjusting .Scale (Fixes #63)
* Add-OBSMediaSource: Fixing -InputSettings / -SceneItemEnabled (Fixes #62)

---


## obs-powershell 0.1.5:

* Adding OBS.SceneItem .Animate (Fixes #59)


---


## obs-powershell 0.1.4:

* Adding Add-OBSColorSource (Fixes #51)  
* Save-OBSSourceScreenShot:
  * Attaching .InputName, .SourceName, .ImageWidth, .ImageHeight to output (Fixes #50)
  * Now returns a file (Fixes #49)
* -Path parameters now attempt to resolve to an absolute path (Fixes #48)
* All scene items can now:
  * Blend() / get .BlendMode (Fixes #53)
  * FitToScreen() (Fixes #46)
  * Crop() (Fixes #57)
  * Rotate() (Fixes #35)
* Color Sources can now .SetColor (Fixes #55)

---

## obs-powershell 0.1.3:

* Requiring ThreadJob Module (Thanks @nyanhp!) (Fixes #36)
* Fixing Add-OBSBrowserSource (Fixes #34)
* Improving Batch Processing Capabilities (Fixes #38)
* Requiring PowerShell Version 7

---


## obs-powershell 0.1.2:

* New Commands
  * Add-OBSBrowserSource (Fixes #24)
  * Add-OBSDisplaySource (Fixes #25)
  * Add-OBSMediaSource (Fixes #28)
  * Clear-OBSScene (Fixes #27)
* New Methods
  * OBS.GetSceneListResponse:
    * .Remove()/.Delete() (Fixes #26)
    * .Lock()/.Unlock() (Fixes #32)
* General Improvements
  * Standardizing Parameter Naming (Fixes #30)  
  * Using GUIDs for RequestIDs (Fixes #29)
  * Updated logo (Fixes #23)
  
---

## obs-powershell 0.1.1

* Connect-OBS now caches connections (Fixes #18)
* Adding new core commands:
  * Watch-OBS (Fixes #19)
  * Receive-OBS (Fixes #20)
  * Send-OBS (Fixes #21)
* All commands now support -PassThru (Fixes #16)
* All commands now increment requests correctly (Fixes #15)
* Improved formatting:
  * Get-OBSScene (Fixes #14)
  * Get-OBSSceneItem (Fixes #17)

---

## obs-powershell 0.1

Initial Release of obs-powershell

* Connect-OBS/Disconnect-OBS let you connect and disconnect.
* Commands exist for every request in the websocket.
* OBS Events are broadcast to the the runspace.
