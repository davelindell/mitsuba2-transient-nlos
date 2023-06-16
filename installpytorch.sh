case "$OSTYPE" in
  linux*)   system="linux" ;;
  darwin*)  system="macos" ;;
  msys*)    system="windows" ;;
  *)        echo "Unknown system: $OSTYPE"
            exit 1
            ;;
esac

case "$system" in
  linux)   download_url="https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-2.0.1%2Bcpu.zip" ;;
  macos)   download_url="https://download.pytorch.org/libtorch/cpu/libtorch-macos-2.0.1.zip" ;;
  windows) download_url="https://download.pytorch.org/libtorch/cpu/libtorch-win-shared-with-deps-2.0.1%2Bcpu.zip" ;;
  *)       echo "Unsupported system: $system"
           exit 1
           ;;
esac

file_name="libtorch-installation.zip"
destination_dir="./ext"

# Download the file
echo "Downloading file..."
wget -q "$download_url" -O "$destination_dir/$file_name"

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "Download completed."

    # Unzip the file
    echo "Unzipping file..."
    unzip -q "$destination_dir/$file_name" -d "$destination_dir"

    # Check if the unzip was successful
    if [ $? -eq 0 ]; then
        echo "Unzip completed."
    else
        echo "Unzip failed."
    fi
else
    echo "Download failed."
fi