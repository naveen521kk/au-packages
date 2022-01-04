$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = 'https://github.com/love2d/love/releases/download/11.4/love-11.4-win32.exe'
  url64bit      = 'https://github.com/love2d/love/releases/download/11.4/love-11.4-win64.exe'
  softwareName  = 'love*'
  checksum      = '316018a3fc0f493a0e487d289a5377cb57a828e7d4412c0c753dff30ff7a6f2e'
  checksumType  = 'sha256'
  checksum64    = 'ccf5b952385cbe138a67c8afc0e6ceed25fae2c61cbcd760e6115df2ee113fce'
  checksumType64= 'sha256'
  silentArgs   = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs 

Install-ChocolateyPath "$($env:SystemDrive)\Program Files\LOVE" 'Machine'
