$ErrorActionPreference = 'Stop';
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$InstallLocation = Get-ToolsLocation
. $toolsPath\helper.ps1
Uninstall-ChocolateyPath "$InstallLocation\Manim\Scripts"

$installInfo = Get-Content "$InstallLocation\Manim\installInfo.json" | ConvertFrom-JSON
Remove-Item `
  -Path "$($installInfo.sitePackageFolder)\manimce.pth" `
  -Force
