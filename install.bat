@echo off
setlocal enabledelayedexpansion
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "packId=135"
set "packVersion=100580"

set "downloadUrl=https://github.com/FTBTeam/FTB-Server-Installer/releases/latest/download/ftb-server-"

IF "%packId%"=="" (
    echo %ESC%[31mMissing pack id, please contact FTB%ESC%[0m
    exit /b 1
)

IF "%packVersion%"=="" (
    echo %ESC%[31mMissing pack version, please contact FTB%ESC%[0m
    exit /b 1
)

reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PROCESSOR_ARCHITECTURE >nul 2>&1
for /f "tokens=3" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PROCESSOR_ARCHITECTURE 2^>nul') do set "sysArch=%%A"


set "arch=amd64"
if /i "%sysArch%"=="ARM64" (
   set "arch=arm64"
)

set "completeUrl=%downloadUrl%windows-%arch%.exe"

echo Downloading FTB Server Installer from: %completeUrl%

set "fileName=ftb-server-installer"

IF NOT "%packId%"=="REPLACE_ME" (
    set "fileName=%fileName%_%packId%"
)
IF NOT "%packVersion%"=="REPLACE_ME" (
    set "fileName=%fileName%_%packVersion%"
)

curl -L -o %fileName%.exe %completeUrl%

IF %ERRORLEVEL% NEQ 0 (
    echo %ESC%[31mFailed to download the file. Please check the URL or your internet connection.%ESC%[0m
    pause
    exit /b %ERRORLEVEL%
)

echo %ESC%[32mDownloaded FTB Server Installer to: %~dp0%fileName%.exe%ESC%[0m
echo %ESC%[36mYou can now run the installer using the command: .\%fileName%.exe%ESC%[0m