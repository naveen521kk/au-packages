$ErrorActionPreference = 'Stop';
$InstallLocation = Get-ToolsLocation
$version = '0.3.0'

$python = (Get-Command python).source #to lock over specific python version
if ($null -eq $python) {
  $python = (Get-Command python).Definition #support powershell 4 as it has different syntax for above one
}

Write-Host "Found python at '$python' using it."
Write-Host "Using python version $(python --version --version)" -ForegroundColor Red
$sitePackageFolder = & "$python" -c "import sysconfig;print(sysconfig.get_path('purelib'))"
New-Item -ItemType Directory -Force -Path "$sitePackageFolder"
$install = @{
  "python"            = $python
  "sitePackageFolder" = $sitePackageFolder
}  | ConvertTo-Json
New-Item -ItemType Directory -Force -Path "$InstallLocation\Manim"
New-Item "$InstallLocation\Manim\installInfo.json" -Force -ItemType file -Value $install #save install info

Write-Host "Upgrading pip and install Wheel" -ForegroundColor Yellow
& "$python" -m ensurepip
& "$python" -m pip install --upgrade pip wheel

Write-Host "Installing Manim to $InstallLocation\Manim"
& "$python" -m pip install "manim==$version" --no-cache --compile --prefix="$InstallLocation\Manim" --no-warn-script-location --log="pip.log" --no-warn-conflicts

Write-Host "Making $python detect the Manim"
New-Item -ItemType Directory -Force -Path "$sitePackageFolder"
$pthFilePath = "$sitePackageFolder\manimce.pth"
$pthFileContent = "$InstallLocation\Manim\Lib\site-packages"
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines($pthFilePath, $pthFileContent, $Utf8NoBomEncoding)


Write-Host "Adding $InstallLocation\Manim\Scripts to `$PATH"
Install-ChocolateyPath "$InstallLocation\Manim\Scripts" 'Machine'
