import-module au

#for love2d
$releases = 'https://github.com/love2d/love/releases/'
$github_api_url='https://api.github.com/repos/love2d/love/releases'

$Options = [ordered]@{
  Timeout = 100
  Threads = 15
  Push    = $true
    
  # Save text report in the local file report.txt
  Report = @{
      Type = 'text'
      Path = "$PSScriptRoot\report.txt"
  }
  
  # Then save this report as a gist using your api key and gist id
  Gist = @{
      ApiKey = $Env:github_api_key
      Id     = $Env:github_gist_id
      Path   = "$PSScriptRoot\report.txt"
  }

  # Persist pushed packages to your repository
  Git = @{
      User = 'naveen521kk'
      Password = $Env:github_api_key
  }
  
  # Then save run info which can be loaded with Import-CliXML and inspected
  RunInfo = @{
      Path = "$PSScriptRoot\update_info.xml"
  }

  # Finally, send an email to the user if any error occurs and attach previously created run info
  Mail = if ($Env:mail_user) {
          @{
             To          = $Env:mail_user
             Server      = 'smtp.gmail.com'
             UserName    = $Env:mail_user
             Password    = $Env:mail_pass
             Port        = 587
             EnableSsl   = $true
             Attachment  = "$PSScriptRoot\$update_info.xml"
             UserMessage = 'Save attachment and load it for detailed inspection: <code>$info = Import-CliXCML update_info.xml</code>'
          }
  } else {}
}
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
  return @{ Version = $version; URL64 = $url64; URL32 = $url32; RELEASENOTES = $releasenotes}
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
      "(?i)(<releaseNotes>)(.*?)(<\/releaseNotes>)"   = "`${1}$($Latest.RELEASENOTES)`${3}"
    }
  }
}

update
