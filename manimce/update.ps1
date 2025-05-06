import-module Chocolatey-AU

$github_api_url = 'https://api.github.com/repos/manimcommunity/manim/releases'

function global:au_GetLatest {
  $contentFetched = Invoke-WebRequest $github_api_url | ConvertFrom-Json
  $i = 0
  $stableRelease = $contentFetched[0]
  while ($contentFetched[$i].prerelease -eq $true) {
    $stableRelease = $j[$i + 1]
    $i = $i + 1
  }
  $version = $stableRelease.tag_name
  $version = Get-Version $version
  return @{ Version = $version; }
}

function global:au_SearchReplace {
  @{
    ".\manimce.nuspec"        = @{
      "(?im)(<docsUrl>)(.*?)(<\/docsUrl>)" = "`${1}https://docs.manim.community/en/v$(($Latest.Version -split '\.')[0,1,2] -join '.')`${3}"
    }
    ".\tools\chocolateyinstall.ps1" = @{
      "(?i)(^.*version\s*=\s*)'.*'" = "`${1}'$(($Latest.Version -split '\.')[0,1,2] -join '.')'"
    }
  }
}

update -ChecksumFor none

