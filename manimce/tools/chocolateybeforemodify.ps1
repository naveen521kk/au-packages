$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$InstallLocation = Get-ToolsLocation
Remove-Item $InstallLocation\Manim -Recurse
