import-module au

$gem_api_url='https://rubygems.org/api/v1/versions/travis/latest.json'
# Looks like they don'[t publish release in Github so dirctly taking from gem API.
function global:au_GetLatest {
  $contentFetched = Invoke-WebRequest $gem_api_url | ConvertFrom-Json
  $version = $stableRelease.version
  return @{ Version = $version; }
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyinstall.ps1" = @{
      "(?i)(^.*version\s*=\s*)'.*'"    = "`${1}'$($Latest.Version)'"
    }
  }
}

update -ChecksumFor none
