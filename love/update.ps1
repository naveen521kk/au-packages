import-module au

#for love
$releases = 'https://github.com/love2d/love/releases/'
$github_api_url='https://api.github.com/repos/love2d/love/releases'

function global:au_GetLatest {
  $contentFetched = Invoke-WebRequest $github_api_url | ConvertFrom-Json
  $i=0
  $stableRelease=$contentFetched[0]
  while ($contentFetched[$i].prerelease -eq $true){
    $stableRelease=$j[$i+1]
    $i=$i+1
  }
  $regex32 = '.*love-.*-win32.exe'
  $regex64 = '.*love-.*-win64.exe'
  foreach ($asset in $stableRelease.assets){
    if (!($url64)){
       $url64   = Select-String -InputObject $asset.browser_download_url -Pattern $regex64
       $id64 = $asset.id
    }
    if (!($url32)){
       $url32   = Select-String -InputObject $asset.browser_download_url -Pattern $regex32
       $id32 = $asset.id
      }
    if ($url64 -and $url32){
      break
    }
  }
  $version = $stableRelease.tag_name
  $releasenotes=$stableRelease.body
  $releasenotes=[System.Security.SecurityElement]::Escape($releasenotes)
  return @{ Version = $version; URL64 = $url64; URL32 = $url32;}
}
function global:au_AfterUpdate {
     $version = $Latest.Version
	 [xml]$oXMLDocument=Get-Content -Path "love.nuspec"
	 $oXMLDocument.package.metadata.dependencies.dependency.version = $version
	 $oXMLDocument.package.metadata.releasenotes = "https://love2d.org/wiki/$($Latest.Version)"
	 $oXMLDocument.Save("$($PWD)\love.nuspec")
}
function global:au_SearchReplace {
  @{
    ".\love.nuspec" = @{
      "(?im)(<releaseNotes>)(.*?)(<\/releaseNotes>)"   = "`${1}https://love2d.org/wiki/$($Latest.Version)`${3}"
    }
  }
}

update -ChecksumFor none
