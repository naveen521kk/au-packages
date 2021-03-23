$ErrorActionPreference = 'Stop';

$InstallLocation = "$(Get-ToolsLocation)\Nim"
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

. $toolsDir\helper.ps1

Uninstall-ChocolateyPath "$(Get-Item $InstallLocation\*)\bin"
Uninstall-ChocolateyPath "$($env:USERPROFILE)\.nimble\bin"
