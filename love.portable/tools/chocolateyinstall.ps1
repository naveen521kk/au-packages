$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://github.com/love2d/love/releases/download/11.3/love-11.3-win32.zip'
  url64bit      = 'https://github.com/love2d/love/releases/download/11.3/love-11.3-win64.zip'
  checksum      = '6c94a62283dcc0f9927de0a07a8c00571b5f4c23de2779cbab3f2c63cfb8ce3c'
  checksumType  = 'sha256'
  checksum64    = 'eb3cdc9aef3a0ddf14a0f01b4ec2a93a37b8e26c52176291dfe79394a03f739c'
  checksumType64= 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
