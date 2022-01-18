$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType       = 'MSI'
  url           = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.28-windows-x86-32bit.msi'
  url64bit      = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.28-windows-x86-64bit.msi'
  checksum       = '7330ec2dc5c92a9d1d7929138f6e06c858a75192a317eb1aa6266f70c84fc84a'
  checksumType   = 'sha256'
  checksum64    = '70a6802ada5bfa0eda61f2300297b085356e34bcb7100a8f33c1c44e5696b863'
  checksumType64= 'sha256'
  softwareName   = 'mysql connector python**'
  silentArgs    = "/qn"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
