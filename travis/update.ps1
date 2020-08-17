import-module au

$github_api_url='https://api.github.com/repos/travis-ci/travis.rb/releases'

function global:au_GetLatest {
  $contentFetched = Invoke-WebRequest $github_api_url | ConvertFrom-Json
  $i=0
  $stableRelease=$contentFetched[0]
  while ($contentFetched[$i].prerelease -eq $true){
    $stableRelease=$j[$i+1]
    $i=$i+1
  }
  $version = $stableRelease.tag_name.Substring(1)
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
