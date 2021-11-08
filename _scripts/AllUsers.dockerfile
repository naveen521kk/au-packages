FROM mcr.microsoft.com/windows/servercore:ltsc2019
WORKDIR C:/app

ARG $INSTALLER_NAME
ARG $CHOCOLATEY_NUPKG

# Install chocolatey
RUN @powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Copy and run the installer
COPY $INSTALLER_NAME python-installer.exe
RUN C:/app/python-installer.exe /quiet InstallAllUsers=1

# Copy stuff
COPY $CHOCOLATEY_NUPKG $CHOCOLATEY_NUPKG
