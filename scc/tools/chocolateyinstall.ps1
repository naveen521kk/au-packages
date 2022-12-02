$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$zipArgs = @{
  Destination    = $toolsDir
  FileFullPath   = "$(Get-Item $toolsDir\scc*i386*)"
  FileFullPath64 = "$(Get-Item $toolsDir\scc*x86_64*)"
}
Get-ChocolateyUnzip @zipArgs
 