import-module au

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
    ".\manim.nuspec" = @{
      "(?im)(<docsUrl>)(.*?)(<\/docsUrl>)"                             = "`${1}https://manimce.readthedocs.io/en/v$($Latest.Version)/`${3}"
      "(?i)(<dependency id=`"manim.install`" version=`")(.*?)(`" \/>)" = "`${1}[$($Latest.Version)]`${3}"
    }
  }
}

update -ChecksumFor none