import-module au

$github_api_url = 'https://api.github.com/repos/boyter/scc/releases'
function global:au_GetLatest {
  $contentFetched = Invoke-WebRequest $github_api_url | ConvertFrom-Json
  $i = 0
  $stableRelease = $contentFetched[0]
  while ($contentFetched[$i].prerelease -eq $true) {
    $stableRelease = $j[$i + 1]
    $i = $i + 1
  }
  $regex32 = '.*scc-.*-i386-pc-windows.zip'
  $regex64 = '.*scc-.*-x86_64-pc-windows.zip'
  foreach ($asset in $stableRelease.assets) {
    if (!($url64)) {
      $url64 = Select-String -InputObject $asset.browser_download_url -Pattern $regex64
      $id64 = $asset.id
    }
    if (!($url32)) {
      $url32 = Select-String -InputObject $asset.browser_download_url -Pattern $regex32
      $id32 = $asset.id
    }
    if ($url64 -and $url32) {
      break
    }
  }
  $version = $stableRelease.tag_name
  $version = Get-Version $version
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
    "tools\chocolateyInstall.ps1" = @{
      "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
  }
}
update -ChecksumFor none -NoCheckUrl
