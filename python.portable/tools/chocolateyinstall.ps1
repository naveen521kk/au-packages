$ErrorActionPreference = 'Stop';
$version = '3.8.5.20200816'.SubString(0,5)
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$osBitness = Get-OSArchitectureWidth -Compare 32 -or $env:ChocolateyForceX86 -eq "true"
$nugetUrl="https://dist.nuget.org/win-x86-commandline/v5.8.0-preview.1/nuget.exe"

$nugetLoc = Get-ChocolateyWebFile `
  -PackageName "Nuget" `
  -FileFullPath "$toolsDir\nuget.exe" `
  -Url $nugetUrl `
  -Checksum "de9bd4de656fedd091ceeb0e14ac918a" `
  -ChecksumType "md5"

if ( $osBitness ){
  & "$toolsDir\nuget.exe" install pythonx86 -Version $version -OutputDirectory "$toolsDir\Python" -Verbosity "quiet"
} else {
  & "$toolsDir\nuget.exe" install python -Version $version -OutputDirectory "$toolsDir\Python" -Verbosity "quiet"
}

Remove-Item $toolsDir\nuget.exe
