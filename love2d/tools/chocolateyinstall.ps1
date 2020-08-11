

$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = 'https://github.com/love2d/love/releases/download/11.3/love-11.3-win32.exe'
  url64bit      = 'https://github.com/love2d/love/releases/download/11.3/love-11.3-win64.exe'
  softwareName  = 'love*'
  checksum      = ''
  checksumType  = ''
  checksum64    = ''
  checksumType64= ''
  silentArgs   = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs 

Install-ChocolateyPath "$($env:SystemDrive)\Program Files\LOVE" 'Machine'
