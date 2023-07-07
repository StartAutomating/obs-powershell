<#
.SYNOPSIS
    Stars an Effect
.DESCRIPTION
    Stars an Effect in obs-powershell.
#>
# If the effect has no messages
if (-not $this.Messages -and 
    # and it is a command
    $this.pstypenames -like '*Command*') {
    # then get read to run it.
    $null = New-Event -SourceIdentifier "OBS.PowerShell.Effect.Command.Started" -MessageData $this
    
    $thisOutput = 
        # If this method had args
        if ($args) {
            $splat = [Ordered]@{}
            $argSplat = @(
                foreach ($arg in $args) {
                    # find and join all of the dictionaries into a splat
                    if ($arg -is [Collections.IDictionary]) {
                        try { $splat += $arg} catch { 
                            foreach ($kv in $arg.GetEnumerator()) {
                                if (-not $splat.Contains($kv.Key)) {
                                    $splat[$kv.Key] = $kv.Value
                                }
                            }
                        }
                    }
                    else {
                        # and pass everything else positionally
                        $arg
                    }
                }                
            )
            # Cache these values
            $This | Add-Member -MemberType NoteProperty LastParameters $splat -Force
            $This | Add-Member -MemberType NoteProperty LastArguments $argSplat -Force
            # and run this
            & $this @Splat @argSplat
        } else {
            # If we had no args, use the last parameters.
            $lastParameters = 
                if ($this.LastParameters) {
                    $this.LastParameters
                } else {
                    @{}
                }
            $lastArguments = 
                if ($this.LastArguments) {
                    @($this.LastArguments)
                } else {
                    @()
                }
            & $this @LastParameters @lastArguments
        }
    
    $null = New-Event -SourceIdentifier "OBS.PowerShell.Effect.Command.Completed" -MessageData $this
    if ($thisOutput) {
        $this | Add-Member -MemberType NoteProperty Messages $thisOutput -Force
        $this | Add-Member -MemberType NoteProperty '.Changes' $null -Force
    }
}

if ($this.Messages) {
    $totalMS  = [double]0
    $messages = @($This.Messages)
    if ($this.Reversed) {
        [Array]::Reverse($messages)
    }
    foreach ($msg in $messages) {
        if ($msg.RequestType -eq 'Sleep') {
            $totalMS += $msg.RequestData.sleepMillis
        }
    }
    $null = New-Event -SourceIdentifier "OBS.PowerShell.Effect.Started" -MessageData $this    
    $messages | Send-OBS -NoResponse
    $this | Add-Member NoteProperty Status "Started" -Force
    if ($totalMS) {
        $Timer = [Timers.Timer]::new($totalMS)
        $Timer.AutoReset = $false
        Add-Member -MemberType NoteProperty -InputObject $this -Name Subscription -Value (
            Register-ObjectEvent -InputObject $timer -EventName Elapsed -Action {
                
                $null = New-Event -SourceIdentifier "OBS.PowerShell.Effect.Ended" -MessageData $event.MessageData
                $effectInfo = $event.MessageData
                if ($effectInfo.LoopCount -is [int] -and $effectInfo.LoopCount -ge 1) {
                    $effectInfo.LoopCount = $effectInfo.LoopCount - 1
                }
                
                $effectInfo  | 
                    Add-Member -MemberType NoteProperty Status 'Ended' -Force
                if ($effectInfo.Mode -match 'Bounce' -and $effectInfo.Mode -match 'Loop') {
                    $effectInfo.Reversed = -not $effectInfo.Reversed
                    $effectInfo.Start()
                } elseif ($effectInfo.Mode -match 'Loop') {
                    if ($effectInfo.LoopCount -is [int] -and $effectInfo.LoopCount -ge 1) {
                        $effectInfo.Start()
                    } elseif ($effectInfo.LoopCount -isnot [int] -or $effectInfo.LoopCount -lt 0) {
                        $effectInfo.Start()
                    }                    
                } elseif ($effectInfo.Mode -match 'Bounce') {
                    $effectInfo.Reversed = -not $effectInfo.Reversed
                    $effectInfo.Mode = 'Twice'
                    $effectInfo.Start()
                } else {
                    $effectInfo | Add-Member -MemberType NoteProperty Mode 'Once' -Force
                }                
            } -MessageData $this -MaxTriggerCount 1
        )         
        $Timer.Start()
    } else {
        $this | Add-Member -MemberType NoteProperty Status "Ended" -Force
        New-Event -SourceIdentifier "OBS.PowerShell.EffectEnded" -MessageData $this        
    }    
}
