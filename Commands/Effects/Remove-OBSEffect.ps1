function Remove-OBSEffect
{
    <#
    .SYNOPSIS
        Removes OBS Effects
    .DESCRIPTION
        Removes effects currently loaded into OBS-PowerShell.
    .NOTES
        This removes effects from memory, but will not delete effect commands or remove effect scripts.
    .LINK
        Get-OBSEffect
    #>
    param(
    # The name of the effect.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [Alias('Name')]
    [string]
    $EffectName
    )

    begin {
        if (-not $script:OBSFX) {
            $script:OBSFX = [Ordered]@{} 
        }
    }

    process {
        if ($script:OBSFX[$name]) {
            $script:OBSFX.Stop()
            $script:OBSFX.Remove($name)
        }
    }
}
