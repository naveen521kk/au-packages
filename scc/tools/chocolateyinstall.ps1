$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$zipArgs = @{
  Destination    = $toolsDir
  FileFullPath   = "$(Get-Item $toolsDir\scc_*i386*.gz)"
  FileFullPath64 = "$(Get-Item $toolsDir\scc_*x86_64*.gz)"
}

Get-ChocolateyUnzip @zipArgs
 
$zipArgs = @{
  Destination    = $toolsDir
  FileFullPath   = "$(Get-Item $toolsDir\scc*.tar)"
}
Get-ChocolateyUnzip @zipArgs
