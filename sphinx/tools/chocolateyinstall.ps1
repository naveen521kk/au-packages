﻿Update-SessionEnvironment

$version = '7.3.7'

$proxy = Get-EffectiveProxy
if ($proxy) {
  Write-Host "Setting CLI proxy: $proxy"
  $env:http_proxy = $env:https_proxy = $proxy
}

python -m ensurepip #check whether python has pip
python -m pip install Sphinx==$version
