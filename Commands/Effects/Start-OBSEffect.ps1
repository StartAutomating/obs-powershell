function Start-OBSEffect
{
    <#
    .SYNOPSIS
        Starts obs-powershell effects.
    .DESCRIPTION
        Starts an effect in OBS PowerShell.

        An effect is either a series of messages or a command that can produce a series of messages.
    .LINK
        Get-OBSEffect
    #>
    [CmdletBinding(PositionalBinding=$false)]
    param(
    # The name of the effect.
    [Parameter(Mandatory)]
    [string]
    $EffectName,

    # The parameters passed to the effect.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('EffectParameters')]
    [Collections.IDictionary]
    $EffectParameter = @{},

    # The arguments passed to the effect.
    [Parameter(ValueFromRemainingArguments)]
    [Alias('EffectArguments')]
    [PSObject[]]
    $EffectArgument = @(),

    # If provided, will step thru running
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('ticks')]
    [int]
    $Step,

    # The SceneItemID.  If this is provided, the effect will be given a target.
    [Parameter(ValueFromPipelineByPropertyName)]
    [int]
    $SceneItemID,

    # The SceneName.  If this is provided with a -SceneItemID or -SourceName, the effect will be given a target.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $SceneName,

    # The Filter Name.  If this is provided with a -SourceName, the effect will be given a target.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $FilterName,

    # The Source Name.  If this is provided with a -FitlerName -or -SceneName, the effect will be given a target.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $SourceName,

    # If set, will loop the effect.
    [switch]
    $Loop,

    # If set, will bounce the effect
    [switch]
    $Bounce
    )

    process {
        $obsEffect = Get-OBSEffect -EffectName $EffectName

        if (-not $obsEffect) { return }

        if ($loop -or $Bounce) {
            $obsEffect | Add-Member -MemberType NoteProperty Mode "$(if ($Bounce) {"Bounce"})$(if ($loop) {"Loop"})" -Force
        } else {
            $obsEffect | Add-Member -MemberType NoteProperty Mode "Once" -Force
        }

        if ($obsEffect -isnot [Management.Automation.CommandInfo]) {
            if ($step -and $obsEffect.Messages) {
                $obsEffect.Step($step)
                return
            }

            $obsEffect.Start()
            
        } else {
            if ($step -and $obsEffect.Messages) {
                $obsEffect.Step($step)
                return
            }
            
            if (-not $this) {
                if ($_.pstypenames -like '*.GetSourceFilter*') {
                    $this = $_
                } elseif ($FilterName -and $SourceName) {
                    $this = Get-OBSSourceFilter -SourceName $SourceName -FilterName $FilterName
                }

                if ($_.pstypenames -like '*.GetSceneItem*') {
                    $this = $_
                } elseif ($SceneName -and ($SceneItemID -or $SourceName)) {
                    $this = 
                        foreach ($sceneItem in Get-OBSSceneItem -SceneName $SceneName) {
                            if ($SceneItemID -and $sceneItem.SceneItemID -eq $SceneItemID) {
                                $sceneItem;break
                            }
                            elseif ($SceneName -and $sceneItem.SceneName -eq $SceneName) {
                                $sceneItem;break
                            }
                        }                    
                }            
            }

            $obsEffectOutput = & $obsEffect @EffectParameter @EffectArgument
            if ($obsEffectOutput) {                
                $obsEffect | Add-Member NoteProperty Messages $obsEffectOutput -Force
                if ($step) {
                    $obsEffect.Step($step)
                } else {
                    $obsEffect.Start()
                }
            }
        }
        $obsEffect
    
    }
}