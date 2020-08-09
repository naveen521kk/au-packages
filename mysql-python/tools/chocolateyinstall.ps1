$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType       = 'MSI'
  url           = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.21-windows-x86-32bit.msi'
  url64bit      = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.21-windows-x86-64bit.msi'
  checksum       = '57C40472A3C3A8F76D53E1683496B1447EF71FD7FE096C3B947A523EA6F27630'
  checksumType   = 'sha256'
  checksum64    = '54CAC5887987570D4C0ED758529EAD91A87759DD4B7FE66890706C5DD6C64E09'
  checksumType64= 'sha256'
  softwareName   = 'mysql connector python**'
  silentArgs    = "/qn"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
