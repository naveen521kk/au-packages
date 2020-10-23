$ErrorActionPreference = 'Stop';
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$InstallLocation = Get-ToolsLocation
. $toolsPath\helper.ps1
Uninstall-ChocolateyPath "$InstallLocation\pango"
python -m pip uninstall -y -q manimce

