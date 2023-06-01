#requires -Module HelpOut

Import-Module .\obs-powershell.psd1
Save-MarkdownHelp -Module obs-powershell -PassThru -Command (Get-OBSEffect | Where-Object { $_ -is [Management.Automation.CommandInfo]})

