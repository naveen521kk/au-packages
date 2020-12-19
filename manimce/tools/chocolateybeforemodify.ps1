$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$InstallLocation = Get-ToolsLocation
Copy-Item -LiteralPath "$InstallLocation\Manim\installInfo.json" -Destination "$InstallLocation" -Force
Remove-Item $InstallLocation\Manim -Recurse
mkdir $InstallLocation\Manim
Copy-Item -LiteralPath "$InstallLocation\installInfo.json" -Destination "$InstallLocation\Manim" -Force
