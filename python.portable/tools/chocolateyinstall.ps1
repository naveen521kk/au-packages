$ErrorActionPreference = 'Stop';
$version = '3.8.5.20200816'.SubString(0,5)
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$osBitness = Get-OSArchitectureWidth -Compare 32 -or $env:ChocolateyForceX86 -eq "true"
if ( $osBitness ){
  nuget install pythonx86 -Version $version -OutputDirectory "$toolsDir\Python" -Verbosity "quiet"
} else {
  nuget install python -Version $version -OutputDirectory "$toolsDir\Python" -Verbosity "quiet"
}
