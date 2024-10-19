@{
    "runs-on" = "ubuntu-latest"    
    if = '${{ success() }}'
    steps = @(
        @{
            name = 'Check out repository'
            uses = 'actions/checkout@v2'
        }, 
        @{
            name = 'GitLogger'
            uses = 'GitLogging/GitLoggerAction@main'
            id = 'GitLogger'
        },
        @{    
            name = 'Use PSSVG Action'
            uses = 'StartAutomating/PSSVG@main'
            id = 'PSSVG'
        },
        'RunPipeScript',
        'RunEZOut',
        @{
            name = 'Use GitPub Action'
            uses = 'StartAutomating/GitPub@main'
            id  = 'GitPub'
            with = @{                
                PublishParameters = @'
{
    "Get-GitPubIssue": {
        "Repository": '${{github.repository}}'        
    },
    "Get-GitPubRelease": {
        "Repository": '${{github.repository}}'        
    },
    "Publish-GitPubJekyll": {
        "OutputPath": "docs/_posts"
    }
}
'@                    
            }
        }
        'RunHelpOut'
    )
}