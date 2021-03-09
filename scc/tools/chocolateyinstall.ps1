$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$zipArgs = @{
  Destination    = $toolsDir
  FileFullPath   = "$(Get-Item $toolsDir\scc-*-i386-*.zip)"
  FileFullPath64 = "$(Get-Item $toolsDir\scc-*-x86_64-*.zip)"
}
Get-ChocolateyUnzip @zipArgs
