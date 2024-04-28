$ErrorActionPreference = 'Stop';
$InstallLocation = Get-ToolsLocation
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$version = '0.18.1'

. $toolsPath\helper.ps1

$allowed_python_versions = @('3.11', '3.10', '3.9', '3.8') # sync with nuspec

$python = FindPython $allowed_python_versions
Write-Host "Found python at '$python' using it."
$python_version = & "$python" --version --version
Write-Host "Using python version $python_version" -ForegroundColor Red
$sitePackageFolder = & "$python" -c "import sysconfig;print(sysconfig.get_path('purelib'))"
$install = @{
  "python"            = $python
  "sitePackageFolder" = $sitePackageFolder
}  | ConvertTo-Json
New-Item -ItemType Directory -Force -Path "$InstallLocation\Manim"
New-Item "$InstallLocation\Manim\installInfo.json" -Force -ItemType file -Value $install #save install info

$ErrorActionPreference = 'Continue'; # pip fails by giving some warnings
Write-Host "Upgrading pip and install Wheel" -ForegroundColor Yellow
& "$python" -m ensurepip
& "$python" -m pip install --upgrade pip wheel --no-warn-script-location

Write-Host "Installing Manim to $InstallLocation\Manim"
& "$python" -m pip install "manim==$version" --no-cache --compile --prefix="$InstallLocation\Manim" --no-warn-script-location --log="pip.log" --no-warn-conflicts --force
$ErrorActionPreference = 'Stop';

Write-Host "Making $python detect the Manim"
New-Item -ItemType Directory -Force -Path "$sitePackageFolder"
$pthFilePath = "$sitePackageFolder\manimce.pth"
$pthFileContent = "$InstallLocation\Manim\Lib\site-packages"
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines($pthFilePath, $pthFileContent, $Utf8NoBomEncoding)

Write-Host "Adding $InstallLocation\Manim\Scripts to `$PATH"
Install-ChocolateyPath "$InstallLocation\Manim\Scripts" 'Machine'
