FROM mcr.microsoft.com/windows/servercore:ltsc2022
WORKDIR C:/app

ARG INSTALLER_NAME
ARG CHOCOLATEY_NUPKG
ARG MANIM_EXAMPLE_FILE

# Install chocolatey
RUN @powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Copy the installer
COPY $INSTALLER_NAME python-installer.exe

# Copy stuff
COPY $CHOCOLATEY_NUPKG $CHOCOLATEY_NUPKG
COPY $MANIM_EXAMPLE_FILE $MANIM_EXAMPLE_FILE
