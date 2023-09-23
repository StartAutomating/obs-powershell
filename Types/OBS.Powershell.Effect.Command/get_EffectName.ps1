<#
.SYNOPSIS
    Gets the Effect Name
.DESCRIPTION
    Gets the name of an Effect.
#>
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