$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$checksum32 = '740790F39CDCD93F9902471E36FA15F97E4C9DE4B11844F513F2E6036A943D93'
$checksum64 = 'E71FFFAFB302B6AE4571EF426060D161A7BA568ADC14B9BC81592A8B845FD714'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  File           = Get-Item $toolsDir\scc-*-i386-*.zip
  File64         = Get-Item $toolsDir\scc-*-x86_64-*.zip
  checksum       = $checksum32
  checksumType   = 'sha256'
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
