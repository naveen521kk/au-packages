import-module au

$rss_url = 'https://www.nuget.org/packages/python/atom.xml'

function global:au_GetLatest {
  $contentFetched = [xml](Invoke-WebRequest $rss_url)
  $i=0
  $stableRelease=$contentFetched.feed.entry[$i]
  $stableReleaseTitle = $contentFetched.feed.entry[$i].title.innertext
  foreach ($stableRelease in $contentFetched.feed.entry){
    $stableReleaseTitle = $stableRelease.title.innertext
    if ((Get-Version $stableReleaseTitle).prerelease -eq ""){
        break
    }
  }
  $version = (Get-Version $stableReleaseTitle).Version
  $releasenotes="https://docs.python.org/release/$version/whatsnew/changelog.html#changelog"
  $LicenseUrl="https://www.python.org/download/releases/$version/license"
  return @{ Version = $version; RELEASENOTES = $releasenotes; LicenseUrl = $LicenseUrl}
}
#todo from here
function global:au_SearchReplace {
  @{
    ".\tools\chocolateyinstall.ps1" = @{
      "(?i)(^\`$version\s*=\s*)'.*"                  = "`${1}'$($Latest.Version)'"
    }
    ".\python.portable.nuspec" = @{
      "(?im)(<releaseNotes>)(.*?)(<\/releaseNotes>)"   = "`${1}$($Latest.RELEASENOTES)`${3}"
      "(?im)(<licenseUrl>)(.*?)(<\/licenseUrl>)"       = "`${1}$($Latest.LicenseUrl)`${3}"
    }
  }
}

update -ChecksumFor none
