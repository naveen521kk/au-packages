$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$zipArgs = @{
  Destination    = $toolsDir
  FileFullPath   = "$(Get-Item $toolsDir\scc_*i386*.zip)"
  FileFullPath64 = "$(Get-Item $toolsDir\scc_*x86_64*.zip)"
}

Get-ChocolateyUnzip @zipArgs
