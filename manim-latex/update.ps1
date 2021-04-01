import-module au

#for tinytex
$releases = 'https://github.com/yihui/tinytex-releases/releases'
$github_api_url='https://api.github.com/repos/yihui/tinytex-releases/releases'

function global:au_GetLatest {
  $contentFetched = Invoke-WebRequest $github_api_url | ConvertFrom-Json
  $i=0
  $stableRelease=$contentFetched[0]
  while ($contentFetched[$i].prerelease -eq $true){
    $stableRelease=$j[$i+1]
    $i=$i+1
  }
  $version = $stableRelease.tag_name
  $version=$version.Substring(1)
  return @{ Version = $version; OrigVersion = $version}
}
function global:au_SearchReplace {
  @{
    ".\manim-latex.nuspec" = @{
	  "(?i)(<dependency id=`"tinytex`" version=`")(.*?)(`" \/>)"   = "`${1}$($Latest.OrigVersion)`${3}"
    }
}
}

update -ChecksumFor none
