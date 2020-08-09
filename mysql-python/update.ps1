import-module au

#for mysql python connector
$releases = 'https://dev.mysql.com/downloads/connector/python/'
$releasesx64 = 'https://dev.mysql.com/downloads/file/?id=496500'
$releasesx32= 'https://dev.mysql.com/downloads/file/?id=496499'
$baserelease = 'https://dev.mysql.com'

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
  $download_page = Invoke-WebRequest -Uri $releasesx64 -UseBasicParsing
  $regex   = '.msi$'
  $url64   = $download_page.links | ? href -match $regex | select -First 1 -expand href
  $version = $url64 -split '-|.msi' | select -Last 1 -Skip 4
  
  $download_page = Invoke-WebRequest -Uri $releasesx32 -UseBasicParsing
  $url32     = $download_page.links | ? href -match $regex | select -First 1 -expand href
  return @{ Version = $version; URL64 = $baserelease+$url64; URL32 = $baserelease+$url32;}
}

function global:au_SearchReplace {
  @{
    ".\tools\VERIFICATION.txt"      = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum32\:).*"          = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyinstall.ps1" = @{
      "(?i)(^\s*Url\s*=\s*)'.*'"                  = "`${1}'$($Latest.URL32)'"
      "(?i)(^\s*Url64bit\s*=\s*)'.*'"             = "`${1}'$($Latest.URL64)'"
      "(?i)(^\s*Checksum\s*=\s*)'.*'"             = "`${1}'$($Latest.Checksum32)'"
      "(?i)(^\s*Checksum64\s*=\s*)'.*'"           = "`${1}'$($Latest.Checksum64)'"
      "(?i)(^\s*ChecksumType\s*=\s*)'.*'"         = "`${1}'$($Latest.ChecksumType32)'"
      "(?i)(^\s*ChecksumType64\s*=\s*)'.*'"       = "`${1}'$($Latest.ChecksumType64)'"
    }
  }
}

update