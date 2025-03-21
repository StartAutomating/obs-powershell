Get-Process obs* | 
    Sort-Object { $_.Name -in 'obs', 'obs64', 'obs32' } |
    Where-Object Name -in 'obs', 'obs64', 'obs32'
    