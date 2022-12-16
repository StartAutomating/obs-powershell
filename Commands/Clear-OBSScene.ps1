function Clear-OBSScene
{
    <#
    .SYNOPSIS
        Clears a Scene in OBS
    .DESCRIPTION
        Clears a Scene in OBS.
        
        All inputs will be removed from the scene.

        This cannot be undone, so you will be prompted for confirmation.
    .EXAMPLE
        Clear-OBSScene -SceneName Scene    
    #>
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='High')]
    param(
    # Name of the scene.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $SceneName
    )

    process {
        if ($PSCmdlet.ShouldProcess("Clear $sceneName")) {
            Get-OBSSceneItem -SceneName $SceneName |
                Remove-OBSSceneItem
        }
    }
}