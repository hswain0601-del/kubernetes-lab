#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="/usr/local/bin"

echo "==> Detecting architecture..."

ARCH=$(uname -m)
case "$ARCH" in
    x86_64|amd64)
        ARCH="amd64"
        ;;
    aarch64|arm64)
        ARCH="arm64"
        ;;
    armv7l)
        ARCH="arm"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

echo "==> Checking required tools..."

for cmd in curl unzip; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: '$cmd' is required but not installed."
        exit 1
    fi
done

echo "==> Fetching latest Terraform version..."

VERSION=$(curl -fsSL https://api.github.com/repos/hashicorp/terraform/releases/latest \
    | grep '"tag_name"' \
    | head -1 \
    | cut -d '"' -f4 \
    | sed 's/^v//')

echo "Latest Version: ${VERSION}"

URL="https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_${ARCH}.zip"

TMP_DIR=$(mktemp -d)

echo "==> Downloading Terraform..."
curl -fsSL "$URL" -o "${TMP_DIR}/terraform.zip"

echo "==> Extracting..."
unzip -q "${TMP_DIR}/terraform.zip" -d "${TMP_DIR}"

echo "==> Installing..."
sudo install -m 755 "${TMP_DIR}/terraform" "${INSTALL_DIR}/terraform"

rm -rf "${TMP_DIR}"

echo
echo "Terraform installed successfully!"
terraform version