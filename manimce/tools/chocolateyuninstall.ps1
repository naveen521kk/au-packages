$ErrorActionPreference = 'Stop';
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$InstallLocation = Get-ToolsLocation
. $toolsPath\helper.ps1
Uninstall-ChocolateyPath "$InstallLocation\pango"
$installInfo = Get-Content "$InstallLocation\Manim\installInfo.json" | ConvertFrom-JSON
Uninstall-BinFile `
  -Name "manim" `
  -Path "manim.exe"
Uninstall-BinFile `
  -Name "manimcm" `
  -Path "manimcm.exe"
Remove-Item `
  -Path "$($installInfo.sitePackageFolder)\manimce.pth" `
  -Force
