import-module Chocolatey-AU

$github_api_url = 'https://api.github.com/repos/nim-lang/Nim/tags'
function global:au_GetLatest {
  $contentFetched = Invoke-WebRequest $github_api_url | ConvertFrom-Json
  $stableRelease = $contentFetched[0]
  $version = $stableRelease.name
  $version = Get-Version $version
  $url32 = "https://nim-lang.org/download/nim-$($version)_x32.zip"
  $url64 = "https://nim-lang.org/download/nim-$($version)_x64.zip"
  return @{ Version = $version; URL64 = $url64; URL32 = $url32; }
}
function global:au_BeforeUpdate { 
  Get-RemoteFiles -Purge -NoSuffix -Algorithm 'sha256'
}
function global:au_SearchReplace {
  @{
    ".\tools\VERIFICATION.txt"    = @{
      "(?i)(\s+x32:).*"     = "`${1} $($Latest.URL32)"
      "(?i)(\s+x64:).*"     = "`${1} $($Latest.URL64)"
      "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
      "(?i)(checksum64:).*" = "`${1} $($Latest.Checksum64)"
    }
  }
}
update -ChecksumFor none
