$ErrorActionPreference = 'Stop';
$rootDir = $args[0]
$dockerFile = $args[1]

$installerUrl = "https://www.python.org/ftp/python/3.11.2/python-3.11.2-amd64.exe"


# build manim nupkg
Set-Location "$rootDir/manimce"
choco pack
$nupkgPath = (Resolve-Path -Path "*.nupkg").path


$tempFolderPath = Join-Path $Env:Temp $(New-Guid); New-Item -Type Directory -Path $tempFolderPath | Out-Null
Set-Location $tempFolderPath

# Download Installer
Invoke-WebRequest -Uri $installerUrl -OutFile "python-installer.exe"

# Download manim example file
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ManimCommunity/manim/master/example_scenes/basic.py" -OutFile "basic.py"

# Copy the docker file and nupkg
Copy-Item "$rootDir/_scripts/$dockerFile" -Destination "$tempFolderPath/$dockerFile"
Copy-Item "$nupkgPath" -Destination "$tempFolderPath/$(Split-Path $nupkgPath -leaf)"

Write-Output "::group::Building Container"
docker build --build-arg INSTALLER_NAME="python-installer.exe" `
    --build-arg CHOCOLATEY_NUPKG="$(Split-Path $nupkgPath -leaf)" `
    --build-arg MANIM_EXAMPLE_FILE="basic.py" `
    -f "$tempFolderPath/$dockerFile" `
    -t "naveen521kk/test-windows" .

Write-Output "::endgroup::"
Write-Output "::group::Running Install"

# Python install failes in user.
if ($dockerFile -eq "ManimOnlyUserInstall.dockerfile") {
    docker container run `
        --rm naveen521kk/test-windows `
        powershell -Command `
        "choco install --no-progress -y manimce -source `"'.;https://chocolatey.org/api/v2/'`" --ignore-dependencies; manim basic.py SquareToCircle"

}
else {
    docker container run `
        --rm naveen521kk/test-windows `
        powershell -Command `
        "choco install --no-progress -y manimce -source `"'.;https://chocolatey.org/api/v2/'`"; manim basic.py SquareToCircle"

}

Write-Output "::endgroup::"
