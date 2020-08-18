$ErrorActionPreference = 'Stop';
$version = '3.8.5.20200816'.SubString(0,5)
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$osBitness = Get-OSArchitectureWidth -Compare 32 -or $env:ChocolateyForceX86 -eq "true"
$nugetUrl="https://dist.nuget.org/win-x86-commandline/v5.8.0-preview.1/nuget.exe"
$nugetLoc = Get-ChocolateyWebFile `
  -PackageName "Nuget" `
  -FileFullPath "$toolsDir\nuget1.exe" `
  -Url $nugetUrl `
  -Checksum "C73E10BA5ED0054C21C382D0A7F040E813C609918E7C1DC3AD601E629146BD2E"
if ( $osBitness ){
  & "$nugetLoc" install pythonx86 -Version $version -OutputDirectory "$toolsDir\Python" -Verbosity "quiet"
} else {
  & "$nugetLoc" install python -Version $version -OutputDirectory "$toolsDir\Python" -Verbosity "quiet"
}
