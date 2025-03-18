#!/bin/bash
set -e

# Define the required version
ACTIONLINT_VERSION="1.7.7"  # Change this to the required version

# Determine OS and Architecture
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"  # Convert OS to lowercase
ARCH="$(uname -m)"

# Map architecture names to match actionlint naming conventions
case "$ARCH" in
  "x86_64") ARCH="amd64" ;;
  "arm64") ARCH="arm64" ;;
  "armv6l") ARCH="armv6" ;;
  "i386") ARCH="386" ;;
esac

# Construct the download URL
FILENAME="actionlint_${ACTIONLINT_VERSION}_${OS}_${ARCH}.tar.gz"
URL="https://github.com/rhysd/actionlint/releases/download/v${ACTIONLINT_VERSION}/${FILENAME}"

# Set install path
INSTALL_DIR="./.cache/bin"
INSTALL_PATH="${INSTALL_DIR}/actionlint"

# Function to install actionlint
install_actionlint() {
  echo "Downloading actionlint v${ACTIONLINT_VERSION} from ${URL}..."
  mkdir -p "$INSTALL_DIR"

  # Download the archive and extract everything into a temporary directory
  TEMP_DIR=$(mktemp -d)
  curl -sL "$URL" | tar -xz -C "$TEMP_DIR"

  # Move the actionlint binary to the install directory
  mv "$TEMP_DIR/actionlint" "$INSTALL_PATH"
  chmod +x "$INSTALL_PATH"

  # Clean up temporary directory
  rm -rf "$TEMP_DIR"
}

# Check if actionlint is installed and at the correct version
if [ -x "$INSTALL_PATH" ]; then
  INSTALLED_VERSION=$("$INSTALL_PATH" --version | awk '{print $2}')
  if [[ "$INSTALLED_VERSION" == "$ACTIONLINT_VERSION" ]]; then
    echo "actionlint v${INSTALLED_VERSION} is already installed."
    exit 0
  else
    echo "Updating actionlint from v${INSTALLED_VERSION} to v${ACTIONLINT_VERSION}..."
  fi
fi

# Install actionlint if not present or outdated
install_actionlint
echo "actionlint v${ACTIONLINT_VERSION} installed successfully at ${INSTALL_PATH}."
