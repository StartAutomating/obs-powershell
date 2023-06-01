$obsEffectsPattern = [Regex]::new('
(?>
    ^OBS.(?>fx|effects?)\p{P}
    |
    [\p{P}-[-]]OBS\.(?>fx|effects?)$
    |
    \p{P}OBS.(?>fx|effects?)\.(?>ps1|json)
)
','IgnoreCase,IgnorePatternWhitespace')

$this.Name -replace $obsEffectsPattern