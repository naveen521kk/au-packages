$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType       = 'MSI'
  url           = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.22-windows-x86-32bit.msi'
  url64bit      = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.22-windows-x86-64bit.msi'
  checksum       = '095c276cf3abf1530d11e4946b4af7e626d219329f64496708793605e0a47366'
  checksumType   = 'sha256'
  checksum64    = 'feaf7615e23545b9f3b727acce36ca30df12d26d28d85b8ca919803a1dea9351'
  checksumType64= 'sha256'
  softwareName   = 'mysql connector python**'
  silentArgs    = "/qn"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
