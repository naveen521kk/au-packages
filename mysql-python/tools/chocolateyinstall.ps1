$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType       = 'MSI'
  url           = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.26-windows-x86-32bit.msi'
  url64bit      = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.26-windows-x86-64bit.msi'
  checksum       = 'bfba928a1151b7e6021c9ba13e1369d78bb5516c92f0c213d453494c6ed36702'
  checksumType   = 'sha256'
  checksum64    = 'f313777196205b6b24211f2bd2ac3d0a2dee83585762784b2bd2bff506fe5944'
  checksumType64= 'sha256'
  softwareName   = 'mysql connector python**'
  silentArgs    = "/qn"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
