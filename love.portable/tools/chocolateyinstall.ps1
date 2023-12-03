$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://github.com/love2d/love/releases/download/11.5/love-11.5-win32.zip'
  url64bit      = 'https://github.com/love2d/love/releases/download/11.5/love-11.5-win64.zip'
  checksum      = '2f452969ff9e86c021ce31225cc066a3c08f85cbc68989965d181005e6693bc9'
  checksumType  = 'sha256'
  checksum64    = '740ac261c0004c4c082138536e4c5f256c5a4b00e0c38d1a1fda44215e06798f'
  checksumType64= 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
