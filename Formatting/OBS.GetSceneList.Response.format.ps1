Write-FormatView -TypeName OBS.GetSceneList.Response -Property Scenes -VirtualProperty @{
    Scenes = {        
        @(foreach ($sceneInfo in $_.scenes) {        
            $currentOrPreview = @(            
                if ($sceneInfo.sceneName -eq $_.currentProgramSceneName) {
                    Format-RichText -InputObject 'current' -ForegroundColor Warning
                }
                if ($sceneInfo.sceneName -eq $_.currentPreviewSceneName) {
                    Format-RichText -InputObject 'preview' -ForegroundColor Verbose
                }
            )

            $sceneInfo.sceneName + ' ' + $(
                if ($currentOrPreview) {
                    "( $($currentOrPreview -join ' ') )"
                }
            )
        }) -join [Environment]::Newline
    }
} -Wrap

Write-FormatView -TypeName OBS.GetSceneList.Response -Action {
    Write-FormatViewExpression -ScriptBlock {
        @(foreach ($sceneInfo in $_.scenes) {        
            $currentOrPreview = @(            
                if ($sceneInfo.sceneName -eq $_.currentProgramSceneName) {
                    Format-RichText -InputObject 'current' -ForegroundColor Warning
                }
                if ($sceneInfo.sceneName -eq $_.currentPreviewSceneName) {
                    Format-RichText -InputObject 'preview' -ForegroundColor Verbose
                }
            )

            $sceneInfo.SceneName + ' ' + $(
                if ($currentOrPreview) {
                    "( $($currentOrPreview -join ' ') )"
                }
            )
        }) -join [Environment]::Newline
    }
}