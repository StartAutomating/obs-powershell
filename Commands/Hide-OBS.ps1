function Hide-OBS {
    <#
    .SYNOPSIS
        Hide OBS
    .DESCRIPTION
        Hides items in OBS
    .EXAMPLE
        Hide-OBS -SourceName "foo"        
    .LINK
        Set-OBSSceneItemEnabled
    #>
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='Medium')]
    param(
    # The name of the item we want to Hide
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [Alias('SourceName','InputName')]
    $ItemName,

    # The name of the scene.  If not provided, the current program scene will be used.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $SceneName
    )

    process {
        # If no scene was provided
        if (-not $SceneName) {
            # find the current program scene
            $sceneName = Get-OBSCurrentProgramScene
        }

        # Walk over all items in the scene
        foreach ($sceneItem in Get-OBSSceneItem -SceneName $SceneName) {
            # If the match our wildcard and we confirm, remove it.
            if ($sceneItem.SourceName -like $ItemName -and
                $PSCmdlet.ShouldProcess("Hide input $($sceneItem.SourceName)")) {
                # Hide it.
                $sceneItem | Set-OBSSceneItemEnabled -SceneItemEnabled:$false
            }            
        }
    }
}

