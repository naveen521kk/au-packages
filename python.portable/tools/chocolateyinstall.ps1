$ErrorActionPreference = 'Stop';
$version = '3.8.5'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$osBitness = Get-ProcessorBits
if ( $osBitness -eq 32 -or $env:ChocolateyForceX86 -eq "true" ){
  nuget install pythonx86 -Version $version -OutputDirectory "$toolsDir\Python" -Verbosity "quiet"
} else {
  nuget install python -Version $version -OutputDirectory "$toolsDir\Python" -Verbosity "quiet"
}
