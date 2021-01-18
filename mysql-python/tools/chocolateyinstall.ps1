$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType       = 'MSI'
  url           = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.23-windows-x86-32bit.msi'
  url64bit      = 'https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-8.0.23-windows-x86-64bit.msi'
  checksum       = '67e25ce0ec8a58609dad7663c6af16cccfa8a43d830ff49732ee1957ad6e27d6'
  checksumType   = 'sha256'
  checksum64    = '9c36ea444bf95420eab377c55341d7dd3c0ef7706ac63f958caf449869af3ec8'
  checksumType64= 'sha256'
  softwareName   = 'mysql connector python**'
  silentArgs    = "/qn"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
