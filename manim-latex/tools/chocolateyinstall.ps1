$ErrorActionPreference = 'Stop'

$toolsDir = Get-ToolsLocation

Write-Host "Updating tlmgr"
#tlmgr is the package manager included in TinyTeX
$statementsToRun = "/C `"$toolsDir\TinyTeX\bin\windows\tlmgr.bat update --self`""
Start-ChocolateyProcessAsAdmin $statementsToRun "$env:WINDIR\system32\cmd.exe"

Write-Host "Installing extra packages"
$statementsToRun = "/C `"$toolsDir\TinyTeX\bin\windows\tlmgr.bat install amsmath babel-english cbfonts-fd cm-super count1to ctex doublestroke dvisvgm everysel fontspec frcursive fundus-calligra gnu-freefont jknapltx latex-bin mathastext microtype multitoc physics preview prelim2e ragged2e relsize rsfs setspace standalone tipa wasy wasysym xcolor xetex xkeyval`""
Start-ChocolateyProcessAsAdmin $statementsToRun "$env:WINDIR\system32\cmd.exe"
