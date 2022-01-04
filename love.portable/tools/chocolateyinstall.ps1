$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://github.com/love2d/love/releases/download/11.4/love-11.4-win32.zip'
  url64bit      = 'https://github.com/love2d/love/releases/download/11.4/love-11.4-win64.zip'
  checksum      = '0d0c42159c6a65bc23a70239171916f0900a2f08f3918e51065e6f1255f5494a'
  checksumType  = 'sha256'
  checksum64    = 'a03180c105557a70e922495ab21279faf327500586238288714d2e695bdc5e78'
  checksumType64= 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
