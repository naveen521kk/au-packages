$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$checksum32 = 'E1D02CDA2F865CD18F0695BA08E376BB363939B8AFAFCA4AD4AE1D8067E28F90'
$checksum64 = 'F3972ACF03C09FF836071D1D173CB49281C8BC0F9682217118565CA62C5559B8'
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
