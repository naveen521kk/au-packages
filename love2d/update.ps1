import-module au

#for love2d
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
  return @{ Version = $version; URL64 = $url64; URL32 = $url32; RELEASENOTES = $releasenotes}
}
function global:au_BeforeUpdate() {
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
}
#todo from here
function global:au_SearchReplace {
  @{
    ".\tools\chocolateyinstall.ps1" = @{
      "(?i)(^\s*Url\s*=\s*)'.*'"                  = "`${1}'$($Latest.URL32)'"
      "(?i)(^\s*Url64bit\s*=\s*)'.*'"             = "`${1}'$($Latest.URL64)'"
      "(?i)(^\s*Checksum\s*=\s*)'.*'"             = "`${1}'$($Latest.Checksum32)'"
      "(?i)(^\s*Checksum64\s*=\s*)'.*'"           = "`${1}'$($Latest.Checksum64)'"
      "(?i)(^\s*ChecksumType\s*=\s*)'.*'"         = "`${1}'$($Latest.ChecksumType32)'"
      "(?i)(^\s*ChecksumType64\s*=\s*)'.*'"       = "`${1}'$($Latest.ChecksumType64)'"
    }
    ".\love2d.nuspec" = @{
      "(?im)(<releaseNotes>)(.*?)(<\/releaseNotes>)"   = "`${1}https://love2d.org/wiki/$($Latest.Version)`${3}"
    }
  }
}

update -ChecksumFor none
