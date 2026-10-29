#!/bin/sh

pack_id="135"
version_id="100580"

base_url="https://github.com/FTBTeam/FTB-Server-Installer/releases/latest/download/ftb-server-"

# Are with on normal linux, freebsd or macOS
os_name=$(uname -s | tr '[:upper:]' '[:lower:]')

target_name=linux
if [ "$os_name" = "linux" ]; then
    target_name="linux"
elif [ "$os_name" = "darwin" ]; then
    target_name="darwin"
elif [ "$os_name" = "freebsd" ]; then
    target_name="freebsd"
else
    echo "Unsupported operating system: $os_name"
    exit 1
fi

# Figure out the users architecture
arch_name=$(uname -m | tr '[:upper:]' '[:lower:]')

if [ "$arch_name" = "x86_64" ] || [ "$arch_name" = "amd64" ] || [ "$arch_name" = "i386" ]; then
    arch_name="amd64"
elif [ "$arch_name" = "aarch64" ] || [ "$arch_name" = "arm64" ]; then
    arch_name="arm64"
else
    echo "Unsupported architecture: $arch_name"
    exit 1
fi

echo "Detected OS: $os_name"
echo "Detected Architecture: $arch_name"
echo "Pack ID: $pack_id"
echo "Version ID: $version_id"
echo "Target Name: $target_name"

download_url="${base_url}${target_name}-${arch_name}"
outname="ftb-server-installer_${pack_id}_${version_id}"

# If the pack id or the version id are still set to the default values, we will use a generic name
if [ "$pack_id" = "REPLACE_ME" ] || [ "$version_id" = "REPLACE_ME" ]; then
    outname="ftb-server-installer"
fi

echo "Downloading FTB Server Installer for $os_name ($arch_name) from $download_url"

# Do we have curl or wget?
if command -v curl >/dev/null 2>&1; then
    # Ensure the file exists before proceeding
    curl -L "$download_url" -o "$outname" || { echo "Failed to download file"; exit 1; }
    chmod +x "$outname"
elif command -v wget >/dev/null 2>&1; then
    # Ensure the file exists before proceeding
    wget "$download_url" -O "$outname" || { echo "Failed to download file"; exit 1; }
    chmod +x "$outname"
else
    echo "Neither curl nor wget is installed. Please install one of them to proceed."
    exit 1
fi

echo "Download complete. You can now run the installer with ./$outname"
