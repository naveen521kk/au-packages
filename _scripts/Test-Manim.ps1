$ErrorActionPreference = 'Stop';
$rootDir = Split-Path $MyInvocation.MyCommand.Definition

$installerUrl = "https://www.python.org/ftp/python/3.9.8/python-3.9.8-amd64.exe"


# build manim nupkg
Set-Location "$rootDir/manimce"
choco pack
$nupkgPath = (Resolve-Path -Path "*.nupkg").path


$tempFolderPath = Join-Path $Env:Temp $(New-Guid); New-Item -Type Directory -Path $tempFolderPath | Out-Null
Set-Location $tempFolderPath

# Download Installer
Invoke-WebRequest -Uri $installerUrl -OutFile "python-installer.exe"

docker build --build-arg INSTALLER_NAME="python-installer.exe" `
    --build-arg CHOCOLATEY_NUPKG="$nupkgPath" `
    -f "$rootDir/_scripts/AllUsers.dockerfile" `
    -t "naveen521kk/test-admin-windows" .


docker container run `
    --rm manimcommunity/minimal-windows `
    powershell -Command `
    "choco install --no-progress manimce -source "'.;https://chocolatey.org/api/v2/'""
