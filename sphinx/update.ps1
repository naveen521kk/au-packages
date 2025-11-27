import-module Chocolatey-AU

$releases = 'https://pypi.python.org/pypi/sphinx'

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]version\s*=\s*)('.*')" = "`${1}'$(($Latest.Version -split '\.')[0,1,2] -join '.')'"
        }
     }
}

function global:au_GetLatest {
    $apiUrl = 'https://pypi.org/pypi/sphinx/json'
    
    $response = Invoke-WebRequest -Uri $apiUrl | ConvertFrom-Json
    if ($null -eq $response) {
        throw "Failed to retrieve the latest version from $apiUrl"
    }

    $version = $response.info.version
    if ($null -eq $version) {
        throw "Failed to find the latest release in the response"
    }

    return @{ Version = $version }
}

update -ChecksumFor none
