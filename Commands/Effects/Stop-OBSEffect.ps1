function Stop-OBSEffect
{
    <#
    .SYNOPSIS
        Stops obs-powershell effects.
    .DESCRIPTION
        Stops an effect in OBS PowerShell.

        A running effect is a series of messages, and the obs-websocket does not let you cancel a message.

        However, OBS effects can be bounced or running in a loop.

        If these effects are stopped, they will not continue to loop or bounce.
    .LINK
        Get-OBSEffect
    .LINK
        Start-OBSEffect
    #>
    param(
    # The name of the effect.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [string]
    $EffectName)

    process {
        $obsEffect = Get-OBSEffect -EffectName $EffectName

        if (-not $obsEffect) { return }

        $obsEffect | Add-Member -MemberType NoteProperty Mode 'Stopped' -Force    
    }
}