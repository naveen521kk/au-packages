$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType       = 'MSI'
  url           = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.27-windows-x86-32bit.msi'
  url64bit      = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.27-windows-x86-64bit.msi'
  checksum       = 'bfbfdfb32f7ffcc42dee7b2a4f3202029f9a18d0be930a6df12c5b17d38abf95'
  checksumType   = 'sha256'
  checksum64    = '9b446843cb4eb093e2eadf9874595033faf5f34897ece62b606b1323ed3ec2e1'
  checksumType64= 'sha256'
  softwareName   = 'mysql connector python**'
  silentArgs    = "/qn"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
