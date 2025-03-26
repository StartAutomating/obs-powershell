@{
    ModuleVersion     = '0.2.0.1'
    RootModule        = 'obs-powershell.psm1'
    Description       = 'Script your streams'
    Guid              = '1417123e-a932-439f-9b68-a7313cf1e170'
    Author            = 'James Brundage'
    CompanyName       = 'Start-Automating'
    Copyright         = '2022-2025 Start-Automating'
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
    FunctionsToExport = 'Clear-OBSScene',
'Connect-OBS',
'Disconnect-OBS',
'Get-OBS',
'Hide-OBS',
'Receive-OBS',
'Remove-OBS',
'Send-OBS',
'Show-OBS',
'Watch-OBS',
'Set-OBSAudioOutputSource',
'Set-OBSBrowserSource',
'Set-OBSColorSource',
'Set-OBSDisplaySource',
'Set-OBSMarkdownSource',
'Set-OBSMediaSource',
'Set-OBSSoundCloudSource',
'Set-OBSSwitchSource',
'Set-OBSVLCSource',
'Set-OBSWaveformSource',
'Set-OBSWindowSource',
'Get-OBS3dSwapTransitionShader',
'Get-OBSAddShader',
'Get-OBSAlphaBorderShader',
'Get-OBSAlphaGamingBentCameraShader',
'Get-OBSAnimatedPathShader',
'Get-OBSAnimatedTextureShader',
'Get-OBSAsciiShader',
'Get-OBSAspectRatioShader',
'Get-OBSBackgroundRemovalShader',
'Get-OBSBlendOpacityShader',
'Get-OBSBlinkShader',
'Get-OBSBloomShader',
'Get-OBSBorderShader',
'Get-OBSBoxBlurShader',
'Get-OBSBulgePinchShader',
'Get-OBSBurnShader',
'Get-OBSCartoonShader',
'Get-OBSCellShadedShader',
'Get-OBSChromaticAberrationShader',
'Get-OBSChromaUVDistortionShader',
'Get-OBSCircleMaskFilterShader',
'Get-OBSClockAnalogShader',
'Get-OBSClockDigitalLedShader',
'Get-OBSClockDigitalNixieShader',
'Get-OBSColorDepthShader',
'Get-OBSColorGradeFilterShader',
'Get-OBSCornerPinShader',
'Get-OBSCrtCurvatureShader',
'Get-OBSCurveShader',
'Get-OBSCutRectPerCornerShader',
'Get-OBSCylinderShader',
'Get-OBSDarkenShader',
'Get-OBSDeadPixelFixerShader',
'Get-OBSDensitySatHueShader',
'Get-OBSDiffuseTransitionShader',
'Get-OBSDigitalRainShader',
'Get-OBSDivideRotateShader',
'Get-OBSDoodleShader',
'Get-OBSDrawingsShader',
'Get-OBSDropShadowShader',
'Get-OBSDrunkShader',
'Get-OBSDynamicMaskShader',
'Get-OBSEdgeDetectionShader',
'Get-OBSEmbersShader',
'Get-OBSEmbossColorShader',
'Get-OBSEmbossShader',
'Get-OBSExeldroBentCameraShader',
'Get-OBSFadeTransitionShader',
'Get-OBSFillColorGradientShader',
'Get-OBSFillColorLinearShader',
'Get-OBSFillColorRadialDegreesShader',
'Get-OBSFillColorRadialPercentageShader',
'Get-OBSFilterTemplateShader',
'Get-OBSFire3Shader',
'Get-OBSFireShader',
'Get-OBSFireworks2Shader',
'Get-OBSFireworksShader',
'Get-OBSFisheyeShader',
'Get-OBSFisheyeXyShader',
'Get-OBSFlipShader',
'Get-OBSFrostedGlassShader',
'Get-OBSGammaCorrectionShader',
'Get-OBSGaussianBlurAdvancedShader',
'Get-OBSGaussianBlurShader',
'Get-OBSGaussianBlurSimpleShader',
'Get-OBSGaussianExampleShader',
'Get-OBSGaussianSimpleShader',
'Get-OBSGbCameraShader',
'Get-OBSGlassShader',
'Get-OBSGlitchAnalogShader',
'Get-OBSGlitchShader',
'Get-OBSGlowShader',
'Get-OBSGradientShader',
'Get-OBSHalftoneShader',
'Get-OBSHeatWaveSimpleShader',
'Get-OBSHexagonShader',
'Get-OBSHslHsvSaturationShader',
'Get-OBSHueRotatonShader',
'Get-OBSIntensityScopeShader',
'Get-OBSInvertLumaShader',
'Get-OBSLuminance2Shader',
'Get-OBSLuminanceAlphaShader',
'Get-OBSLuminanceShader',
'Get-OBSMatrixShader',
'Get-OBSMultiplyShader',
'Get-OBSNightSkyShader',
'Get-OBSOpacityShader',
'Get-OBSPagePeelShader',
'Get-OBSPagePeelTransitionShader',
'Get-OBSPerlinNoiseShader',
'Get-OBSPieChartShader',
'Get-OBSPixelationShader',
'Get-OBSPixelationTransitionShader',
'Get-OBSPolarShader',
'Get-OBSPulseShader',
'Get-OBSRainbowShader',
'Get-OBSRainWindowShader',
'Get-OBSRectangularDropShadowShader',
'Get-OBSReflectShader',
'Get-OBSRemovePartialPixelsShader',
'Get-OBSRepeatShader',
'Get-OBSRepeatTextureShader',
'Get-OBSRGBAPercentShader',
'Get-OBSRgbColorWheelShader',
'Get-OBSRgbSplitShader',
'Get-OBSRgbvisibilityShader',
'Get-OBSRGSSAAShader',
'Get-OBSRippleShader',
'Get-OBSRotatingSourceShader',
'Get-OBSRotatoeShader',
'Get-OBSRoundedRect2Shader',
'Get-OBSRoundedRectPerCornerShader',
'Get-OBSRoundedRectPerSideShader',
'Get-OBSRoundedRectShader',
'Get-OBSRoundedStrokeGradientShader',
'Get-OBSRoundedStrokeShader',
'Get-OBSScanLineShader',
'Get-OBSSeascapeShader',
'Get-OBSSeasickShader',
'Get-OBSSelectiveColorShader',
'Get-OBSShakeShader',
'Get-OBSShineShader',
'Get-OBSSimpleGradientShader',
'Get-OBSSimplexNoiseShader',
'Get-OBSSmartDenoiseShader',
'Get-OBSSpecularShineShader',
'Get-OBSSpotlightShader',
'Get-OBSSwirlShader',
'Get-OBSTetraShader',
'Get-OBSThermalShader',
'Get-OBSTvCrtSubpixelShader',
'Get-OBSTwistShader',
'Get-OBSTwoPassDropShadowShader',
'Get-OBSVCRShader',
'Get-OBSVHSShader',
'Get-OBSVignettingShader',
'Get-OBSVoronoiPixelationShader',
'Get-OBSZigZagShader',
'Get-OBSZoomBlurShader',
'Get-OBSZoomShader',
'Get-OBSZoomXYShader',
'Set-OBS3DFilter',
'Set-OBSColorFilter',
'Set-OBSEqualizerFilter',
'Set-OBSGainFilter',
'Set-OBSRenderDelayFilter',
'Set-OBSScaleFilter',
'Set-OBSScrollFilter',
'Set-OBSShaderFilter',
'Set-OBSSharpnessFilter',
'Add-OBSInput',
'Add-OBSProfile',
'Add-OBSScene',
'Add-OBSSceneCollection',
'Add-OBSSceneItem',
'Add-OBSSourceFilter',
'Copy-OBSSceneItem',
'Get-OBSCurrentPreviewScene',
'Get-OBSCurrentProgramScene',
'Get-OBSCurrentSceneTransition',
'Get-OBSCurrentSceneTransitionCursor',
'Get-OBSGroup',
'Get-OBSGroupSceneItem',
'Get-OBSHotkey',
'Get-OBSInput',
'Get-OBSInputAudioBalance',
'Get-OBSInputAudioMonitorType',
'Get-OBSInputAudioSyncOffset',
'Get-OBSInputAudioTracks',
'Get-OBSInputDefaultSettings',
'Get-OBSInputKind',
'Get-OBSInputMute',
'Get-OBSInputPropertiesListPropertyItems',
'Get-OBSInputSettings',
'Get-OBSInputVolume',
'Get-OBSLastReplayBufferReplay',
'Get-OBSMediaInputStatus',
'Get-OBSMonitor',
'Get-OBSOutput',
'Get-OBSOutputSettings',
'Get-OBSOutputStatus',
'Get-OBSPersistentData',
'Get-OBSProfile',
'Get-OBSProfileParameter',
'Get-OBSRecordDirectory',
'Get-OBSRecordStatus',
'Get-OBSReplayBufferStatus',
'Get-OBSScene',
'Get-OBSSceneCollection',
'Get-OBSSceneItem',
'Get-OBSSceneItemBlendMode',
'Get-OBSSceneItemEnabled',
'Get-OBSSceneItemId',
'Get-OBSSceneItemIndex',
'Get-OBSSceneItemLocked',
'Get-OBSSceneItemSource',
'Get-OBSSceneItemTransform',
'Get-OBSSceneSceneTransitionOverride',
'Get-OBSSceneTransition',
'Get-OBSSourceActive',
'Get-OBSSourceFilter',
'Get-OBSSourceFilterDefaultSettings',
'Get-OBSSourceFilterKind',
'Get-OBSSourceFilterList',
'Get-OBSSourceScreenshot',
'Get-OBSSpecialInputs',
'Get-OBSStats',
'Get-OBSStreamServiceSettings',
'Get-OBSStreamStatus',
'Get-OBSStudioModeEnabled',
'Get-OBSTransitionKind',
'Get-OBSVersion',
'Get-OBSVideoSettings',
'Get-OBSVirtualCamStatus',
'Open-OBSInputFiltersDialog',
'Open-OBSInputInteractDialog',
'Open-OBSInputPropertiesDialog',
'Open-OBSSourceProjector',
'Open-OBSVideoMixProjector',
'Remove-OBSInput',
'Remove-OBSProfile',
'Remove-OBSScene',
'Remove-OBSSceneItem',
'Remove-OBSSourceFilter',
'Resume-OBSRecord',
'Save-OBSReplayBuffer',
'Save-OBSSourceScreenshot',
'Send-OBSCallVendorRequest',
'Send-OBSCustomEvent',
'Send-OBSOffsetMediaInputCursor',
'Send-OBSPauseRecord',
'Send-OBSPressInputPropertiesButton',
'Send-OBSSleep',
'Send-OBSStreamCaption',
'Send-OBSTriggerHotkeyByKeySequence',
'Send-OBSTriggerHotkeyByName',
'Send-OBSTriggerMediaInputAction',
'Send-OBSTriggerStudioModeTransition',
'Set-OBSCurrentPreviewScene',
'Set-OBSCurrentProfile',
'Set-OBSCurrentProgramScene',
'Set-OBSCurrentSceneCollection',
'Set-OBSCurrentSceneTransition',
'Set-OBSCurrentSceneTransitionDuration',
'Set-OBSCurrentSceneTransitionSettings',
'Set-OBSInputAudioBalance',
'Set-OBSInputAudioMonitorType',
'Set-OBSInputAudioSyncOffset',
'Set-OBSInputAudioTracks',
'Set-OBSInputMute',
'Set-OBSInputName',
'Set-OBSInputSettings',
'Set-OBSInputVolume',
'Set-OBSMediaInputCursor',
'Set-OBSOutputSettings',
'Set-OBSPersistentData',
'Set-OBSProfileParameter',
'Set-OBSRecordDirectory',
'Set-OBSSceneItemBlendMode',
'Set-OBSSceneItemEnabled',
'Set-OBSSceneItemIndex',
'Set-OBSSceneItemLocked',
'Set-OBSSceneItemTransform',
'Set-OBSSceneName',
'Set-OBSSceneSceneTransitionOverride',
'Set-OBSSourceFilterEnabled',
'Set-OBSSourceFilterIndex',
'Set-OBSSourceFilterName',
'Set-OBSSourceFilterSettings',
'Set-OBSStreamServiceSettings',
'Set-OBSStudioModeEnabled',
'Set-OBSTBarPosition',
'Set-OBSVideoSettings',
'Start-OBSOutput',
'Start-OBSRecord',
'Start-OBSReplayBuffer',
'Start-OBSStream',
'Start-OBSVirtualCam',
'Stop-OBSOutput',
'Stop-OBSRecord',
'Stop-OBSReplayBuffer',
'Stop-OBSStream',
'Stop-OBSVirtualCam',
'Switch-OBSInputMute',
'Switch-OBSOutput',
'Switch-OBSRecord',
'Switch-OBSRecordPause',
'Switch-OBSReplayBuffer',
'Switch-OBSStream',
'Switch-OBSVirtualCam',
'Get-OBSEffect',
'Import-OBSEffect',
'Remove-OBSEffect',
'Start-OBSEffect',
'Stop-OBSEffect'
}

