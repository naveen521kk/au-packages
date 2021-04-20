$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType       = 'MSI'
  url           = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.24-windows-x86-32bit.msi'
  url64bit      = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.24-windows-x86-64bit.msi'
  checksum       = '692d10e940f8ad9c912e225b244782e244f6273127b765ffc38a07d4d103e0f7'
  checksumType   = 'sha256'
  checksum64    = '204948a40aa739fe685426f635d46ff0cd9a979b74267b607fb573a3f8f8d135'
  checksumType64= 'sha256'
  softwareName   = 'mysql connector python**'
  silentArgs    = "/qn"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
