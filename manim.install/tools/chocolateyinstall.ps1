$ErrorActionPreference = 'Stop';
$InstallLocation = Get-ToolsLocation
$version = '0.0.1'
Install-ChocolateyZipPackage `
  -PackageName "Pango Binaries" `
  -Url "https://github.com/ManimCommunity/pango-windows-binaries/releases/download/v0.1.0/pango-windows-binaires-x86.zip" `
  -UnzipLocation $InstallLocation `
  -Url64bit "https://github.com/ManimCommunity/pango-windows-binaries/releases/download/v0.1.0/pango-windows-binaires-x64.zip" `
  -Checksum "A12F6C6502346462C1C3FC5AA7B1D6DA33DAB4C904E0F9EB5889CB79ACB36871" `
  -ChecksumType "SHA256" `
  -Checksum64 "599E10248B90C408C95AA3429A4DBC4137702242BDDE919A417471E38B100802" `
  -ChecksumType64 "SHA256"
Install-ChocolateyPath "$InstallLocation\pango" 'Machine'
python -m pip install -q "manimce==$version"
