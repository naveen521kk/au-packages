$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = 'https://github.com/love2d/love/releases/download/11.5/love-11.5-win32.exe'
  url64bit      = 'https://github.com/love2d/love/releases/download/11.5/love-11.5-win64.exe'
  softwareName  = 'love*'
  checksum      = '1a25b2751062ff95673dad9a351996ce9f53f6cdd861497deba2e5fa25aa913d'
  checksumType  = 'sha256'
  checksum64    = '108d4ddab8f98c8572ea9b26a144ea8c77bc01cdce875209b366a8abc4b13924'
  checksumType64= 'sha256'
  silentArgs   = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs 

Install-ChocolateyPath "$($env:SystemDrive)\Program Files\LOVE" 'Machine'
