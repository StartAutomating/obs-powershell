function Get-OBSEffect
{
    <#
    .SYNOPSIS
        Gets OBS Effects
    .DESCRIPTION
        Gets effects currently loaded into OBS-PowerShell.

        An effect can be thought of as a name with a series of messages to OBS.

        Those messages can be defined in a .json file or a script, in any module that tags OBS.

        They can also be defined in a function or script named like:
        
        * `*.OBS.FX.*`
        * `*.OBS.Effect.*`
        * `*.OBS.Effects.*`
        
    .LINK
        Import-OBSEffect
    .LINK
        Remove-OBSEffect
    #>
    param(
    # The name of the effect.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('EffectName')]
    [string]
    $Name
    )

    begin {
        if (-not $script:OBSFX) {
            $script:OBSFX = [Ordered]@{} 
        }
    }

    process {

        if (-not $Name) {
            $script:OBSFX.Values
        } elseif ($script:OBSFX[$name]) {
            $script:OBSFX[$name]
        }
    }
}