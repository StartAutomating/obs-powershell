Write-FormatView -TypeName OBS.GetSceneList.Response -Property Scenes -VirtualProperty @{
    Scenes = @(
        @(foreach ($sceneInfo in $_.scenes) {        
            $currentOrPreview = @(            
                if ($sceneInfo.Name -eq $_.currentProgramSceneName) {
                    Format-RichText -InputObject 'current' -ForegroundColor Warning
                }
                if ($sceneInfo.Name -eq $_.currentPreviewSceneName) {
                    Format-RichText -InputObject 'preview' -ForegroundColor Verbose
                }
            )

            $sceneInfo.Name + $(
                if ($currentOrPreview) {
                    "( $($currentOrPreview -join ' ') )"
                }
            )
        }) -join [Environment]::Newline
    )
}

Write-FormatView -TypeName OBS.GetSceneList.Response -Action {
    Write-FormatViewExpression -ScriptBlock {
        @(foreach ($sceneInfo in $_.scenes) {        
            $currentOrPreview = @(            
                if ($sceneInfo.Name -eq $_.currentProgramSceneName) {
                    Format-RichText -InputObject 'current' -ForegroundColor Warning
                }
                if ($sceneInfo.Name -eq $_.currentPreviewSceneName) {
                    Format-RichText -InputObject 'preview' -ForegroundColor Verbose
                }
            )

            $sceneInfo.Name + $(
                if ($currentOrPreview) {
                    "( $($currentOrPreview -join ' ') )"
                }
            )
        }) -join [Environment]::Newline
    }
}