$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType       = 'MSI'
  url           = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.25-windows-x86-32bit.msi'
  url64bit      = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.25-windows-x86-64bit.msi'
  checksum       = '6ecd6bd5a52ded840dfd577e5f6fe66bbc02c14f2aa66a930b396e4739d22264'
  checksumType   = 'sha256'
  checksum64    = '27837a863cddb5e99f71363f1eb45bdacf2247dd060df42f24395e903d0ee51a'
  checksumType64= 'sha256'
  softwareName   = 'mysql connector python**'
  silentArgs    = "/qn"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
