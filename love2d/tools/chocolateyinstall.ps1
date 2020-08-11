

$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = 'https://github.com/love2d/love/releases/download/11.3/love-11.3-win32.exe'
  url64bit      = 'https://github.com/love2d/love/releases/download/11.3/love-11.3-win64.exe'
  softwareName  = 'love*'
  checksum      = 'dc434ef7b427de462ddced513a2f62614fbdc3ce103481771eaf6470d161e3c0'
  checksumType  = 'sha256'
  checksum64    = '46c1d2bab149ce911f0c21d5763a121902f06fe27397d592a09801bfdf726d73'
  checksumType64= 'sha256'
  silentArgs   = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs 

Install-ChocolateyPath "$($env:SystemDrive)\Program Files\LOVE" 'Machine'
