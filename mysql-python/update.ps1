import-module au

#for mysql python connector
$releases = 'https://dev.mysql.com/downloads/connector/python/'
$releasesx64 = 'https://dev.mysql.com/downloads/file/?id=496500'
$releasesx32= 'https://dev.mysql.com/downloads/file/?id=496499'
$baserelease = 'https://dev.mysql.com'


function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releasesx64 -UseBasicParsing
  $regex   = '.msi$'
  $url64     = $download_page.links | ? href -match $regex | select -First 1 -expand href
  $version = $url64 -split '-|.msi' | select -Last 1 -Skip 4
  
  $download_page = Invoke-WebRequest -Uri $releasesx32 -UseBasicParsing
  $url32     = $download_page.links | ? href -match $regex | select -First 1 -expand href
  return @{ Version = $version; URL64 = $baserelease+$url64; URL32 = $baserelease+$url32;}
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum32\:).*"          = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyinstall.ps1" = @{
      "(?i)(^\s*Url\s*=\s*)'.*'"                  = "`${1}'$($Latest.URL32)'"
      "(?i)(^\s*Url64bit\s*=\s*)'.*'"                = "`${1}'$($Latest.URL64)'"
      "(?i)(^\s*Checksum\s*=\s*)'.*'"             = "`${1}'$($Latest.Checksum32)'"
      "(?i)(^\s*Checksum64\s*=\s*)'.*'"           = "`${1}'$($Latest.Checksum64)'"
      "(?i)(^\s*ChecksumType\s*=\s*)'.*'"         = "`${1}'$($Latest.ChecksumType32)'"
      "(?i)(^\s*ChecksumType64\s*=\s*)'.*'"       = "`${1}'$($Latest.ChecksumType64)'"
    }
  }
}

update -ChecksumFor none -NoCheckUrl