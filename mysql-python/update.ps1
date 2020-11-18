import-module au

#for mysql python connector
$releases = 'https://dev.mysql.com/downloads/connector/python/'

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $regex = 'mysql-connector-python-(?<version>\d*\.\d*\.\d*)-windows-x86-64bit.msi'
  $match = $download_page.Content -match $regex | select -First 1
  $version = $Matches.version
  $url64 = "https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-$($version)-windows-x86-64bit.msi"
  $url32 = "https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-$($version)-windows-x86-32bit.msi"
  return @{ Version = $version; URL64 = $url64; URL32 = $url32; }
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyinstall.ps1" = @{
      "(?i)(^\s*Url\s*=\s*)'.*'"            = "`${1}'$($Latest.URL32)'"
      "(?i)(^\s*Url64bit\s*=\s*)'.*'"       = "`${1}'$($Latest.URL64)'"
      "(?i)(^\s*Checksum\s*=\s*)'.*'"       = "`${1}'$($Latest.Checksum32)'"
      "(?i)(^\s*Checksum64\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum64)'"
      "(?i)(^\s*ChecksumType\s*=\s*)'.*'"   = "`${1}'$($Latest.ChecksumType32)'"
      "(?i)(^\s*ChecksumType64\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType64)'"
    }
  }
}

update -NoCheckUrl
