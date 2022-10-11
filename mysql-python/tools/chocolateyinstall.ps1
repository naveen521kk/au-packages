$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType       = 'MSI'
  url           = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.31-windows-x86-32bit.msi'
  url64bit      = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.31-windows-x86-64bit.msi'
  checksum       = 'cfd2161de6030e75682eb45e98aec0166373e87ec933dcd3b84c51c61a7b50c3'
  checksumType   = 'sha256'
  checksum64    = '6df17e94e6b7ba1e9a8832f4522fa118c1f06ab71641c072dc33d1aec09b6258'
  checksumType64= 'sha256'
  softwareName   = 'mysql connector python**'
  silentArgs    = "/qn"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
