$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = 'https://github.com/love2d/love/releases/download/11.5/love-11.5-win32.exe'
  url64bit      = 'https://github.com/love2d/love/releases/download/11.5/love-11.5-win64.exe'
  softwareName  = 'love*'
  checksum      = '11bde8121a734c0453c48c3cd335076ca8063867d2ba25b1c22a3f76b108bf2d'
  checksumType  = 'sha256'
  checksum64    = 'a91ec9beb1ea9fa74ada64c2dd9f052ce142077e718920eb91b059fcfb950faa'
  checksumType64= 'sha256'
  silentArgs   = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs 

Install-ChocolateyPath "$($env:SystemDrive)\Program Files\LOVE" 'Machine'
