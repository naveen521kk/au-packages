$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType       = 'MSI'
  url           = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.30-windows-x86-32bit.msi'
  url64bit      = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.30-windows-x86-64bit.msi'
  checksum       = '1d71e5b2ba2579875ccb2d009bb6897f0c89468bd32bec1a7c50e49eefb165b0'
  checksumType   = 'sha256'
  checksum64    = 'abfa94af9a81d00ef2cdbfde0609a49f14535c6375733f562d97be78588a3968'
  checksumType64= 'sha256'
  softwareName   = 'mysql connector python**'
  silentArgs    = "/qn"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
