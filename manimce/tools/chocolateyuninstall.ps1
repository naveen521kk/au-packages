$ErrorActionPreference = 'Stop';
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$InstallLocation = Get-ToolsLocation
. $toolsPath\helper.ps1
Uninstall-ChocolateyPath "$InstallLocation\pango"

Write-Host "Uninstalling Environment Variables" -ForegroundColor Red
Uninstall-ChocolateyEnvironmentVariable `
  -VariableName "PANGO_LOCATION" `
  -VariableType Machine
Uninstall-ChocolateyEnvironmentVariable `
  -VariableName "GLIB_LOCATION" `
  -VariableType Machine
Uninstall-ChocolateyEnvironmentVariable `
  -VariableName "GOBJECT_LOCATION" `
  -VariableType Machine

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
