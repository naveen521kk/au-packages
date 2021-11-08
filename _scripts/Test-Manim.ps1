$ErrorActionPreference = 'Stop';
$rootDir = $args[0]

$installerUrl = "https://www.python.org/ftp/python/3.9.8/python-3.9.8-amd64.exe"


# build manim nupkg
Set-Location "$rootDir/manimce"
choco pack
$nupkgPath = (Resolve-Path -Path "*.nupkg").path


$tempFolderPath = Join-Path $Env:Temp $(New-Guid); New-Item -Type Directory -Path $tempFolderPath | Out-Null
Set-Location $tempFolderPath

# Download Installer
Invoke-WebRequest -Uri $installerUrl -OutFile "python-installer.exe"

# Copy the docker file
Copy-Item "$rootDir/_scripts/AllUsers.dockerfile" -Destination "$tempFolderPath/AllUsers.dockerfile"

docker build --build-arg INSTALLER_NAME="python-installer.exe" `
    --build-arg CHOCOLATEY_NUPKG="$nupkgPath" `
    -f "$tempFolderPath/AllUsers.dockerfile" `
    -t "naveen521kk/test-admin-windows" .


docker container run `
    --rm naveen521kk/test-admin-windows `
    powershell -Command `
    "choco install --no-progress manimce -source "'.;https://chocolatey.org/api/v2/'""
