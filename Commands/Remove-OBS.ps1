function Remove-OBS {
    <#
    .SYNOPSIS
        Remove OBS
    .DESCRIPTION
        Removes items from OBS
    .EXAMPLE
        Remove-OBS -SourceName "foo"
    .EXAMPLE
        Remove-OBS -SceneName "bar"
    .LINK
        Remove-OBSInput
    .LINK
        Remove-OBSScene
    #>
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='High')]
    param(
    # The name of the item we want to remove
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [Alias('SourceName','InputName','SceneName')]
    $ItemName
    )

    process {
        # If we remove an input, we don't want to remove a scene
        $removedAnInput = $false
        # Go over each input
        foreach ($obsInput in Get-OBSInput) {
            # If it matches our wildcard and we confirm
            if ($obsInput.InputName -like $ItemName -and
                $PSCmdlet.ShouldProcess("Remove input $($obsInput.InputName)")) {
                # remove it.
                Remove-OBSInput -InputName $obsInput.InputName
                $removedAnInput = $true
            }
        }

        # Return if we removed an input.
        if ($removedAnInput) { return }

        # Go over all scenes
        foreach ($obsScene in (Get-OBSScene).Scenes) {
            # If the name matches our wildcard and we confirm
            if ($obsScene.SceneName -like $ItemName -and
                $PSCmdlet.ShouldProcess("Remove scene $($obsScene.SceneName)")) {
                # remove the scene.
                Remove-OBSScene -SceneName $obsScene.SceneName
            }
        }
    }
}