if (!(Test-Path function:\Uninstall-ChocolateyPath)) {
  function Uninstall-ChocolateyPath {
    param(
      [string]$pathToRemove,
      [System.EnvironmentVariableTarget] $pathType = [System.EnvironmentVariableTarget]::User
    )

    Write-Debug "Running 'Uninstall-ChocolateyPath' with pathToRemove: `'$pathToRemove`'"

    # get the PATH variable
    Update-SessionEnvironment
    $envPath = $env:PATH
    if ($envPath.ToLower().Contains($pathToRemove.ToLower())) {
      Write-Host "The PATH environment variable already contains the directory '$pathToRemove'. Removing..."
      $actualPath = Get-EnvironmentVariable -Name 'Path' -Scope $pathType -PreserveVariables

      $newPath = $actualPath -replace [regex]::Escape($pathToRemove + ';'), '' -replace ';;', ';'

      if (($pathType -eq [System.EnvironmentVariableTarget]::Machine) -and !(Test-ProcessAdminRights)) {
        Write-Warning "Removing path from machine environment variable is not supported when not running as an elevated user!"
      }
      else {
        Set-EnvironmentVariable -Name 'Path' -Value $newPath -Scope $pathType
      }

      $env:PATH = $newPath
    }
  }
}

function FindPython {
  param(
    $allowed_python_versions
  )
  # see https://www.python.org/dev/peps/pep-0514/#structure
  # we are querying machine regsitry only because chocolatey
  # installs python in admin mode only.

  Try {
    $avaiable_installation = Get-ChildItem -Path Registry::HKEY_LOCAL_MACHINE\Software\Python\PythonCore | Select-Object Name
  } 
  Catch [System.Management.Automation.ItemNotFoundException]
  {
    Write-Host "Can't find python installed for all users. Searching for user installed python." -ForegroundColor Red
    Write-Warning "This would mean you can't use manim outside of this user."
    $avaiable_installation = Get-ChildItem -Path Registry::HKEY_CURRENT_USER\Software\Python\PythonCore | Select-Object Name
  }

  if ($avaiable_installation.length -gt 1) {
    [array]::Reverse($avaiable_installation)
  }
  foreach ($install in $avaiable_installation) {
    $name_install = $install.Name
    $install_version = ($name_install -split '\\')[-1]
    if ($allowed_python_versions.Contains($install_version)) {
      Write-Host "Found Python $install_version from Registry" -ForegroundColor Yellow
      try {
        $python_executable = Get-ItemProperty -Path "Registry::$name_install\InstallPath" | Select-Object ExecutablePath
        Write-Host "Found Install Path - $($python_executable.ExecutablePath)" -ForegroundColor Yellow
        $path = $python_executable.ExecutablePath
        if (!(Test-Path -Path $path))
        {
          throw [System.IO.FileNotFoundException] "$path not found."
        }
        return $path
      }
      catch {
        Write-Host "Install Path Not Found for $install_version - Skipping" -ForegroundColor Green
      }
    }
  }
  throw "Can't find any python using registry. Try running `choco install python3 --force` and then rerun the command."
}
