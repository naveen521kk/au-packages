$ErrorActionPreference = 'Stop'

$toolsDir = Get-ToolsLocation

Write-Host "Updating tlmgr"
#tlmgr is the package manager included in TinyTeX
$statementsToRun = "/C `"$toolsDir\TinyTeX\bin\windows\tlmgr.bat update --self`""
Start-ChocolateyProcessAsAdmin $statementsToRun "$env:WINDIR\system32\cmd.exe"

Write-Host "Installing extra packages"
$statementsToRun = "/C `"$toolsDir\TinyTeX\bin\windows\tlmgr.bat install standalone everysel ctex frcursive preview doublestroke ms setspace rsfs relsize ragged2e fundus-calligra microtype wasysym physics dvisvgm jknapltx wasy cm-super babel-english gnu-freefont mathastext cbfonts-fd`""
Start-ChocolateyProcessAsAdmin $statementsToRun "$env:WINDIR\system32\cmd.exe"
