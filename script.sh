#!/bin/bash

# Check if gitleaks is enabled in git config
if ! git config --get hooks.gitleaks-enabled | grep -q "true"; then
  echo "Gitleaks hook is disabled. Enable it with 'git config hooks.gitleaks-enabled true'"
  exit 0
fi

# Function to install gitleaks
install_gitleaks() {
  echo "Installing gitleaks..."
  local os=$(uname | tr '[:upper:]' '[:lower:]')
  local arch=$(uname -m)

  if [ "$arch" == "x86_64" ]; then
    arch="amd64"
  elif [ "$arch" == "aarch64" ]; then
    arch="arm64"
  fi

  local url="https://github.com/gitleaks/gitleaks/releases/latest/download/gitleaks_${os}_${arch}.tar.gz"
  
  curl -sSL $url -o gitleaks.tar.gz
  tar -xzf gitleaks.tar.gz gitleaks
  rm gitleaks.tar.gz
  chmod +x gitleaks
  mv gitleaks /usr/local/bin/gitleaks
}

# Check if gitleaks is installed
if ! command -v gitleaks &> /dev/null; then
  install_gitleaks
fi

# Run gitleaks to check for secrets
gitleaks detect --source . --verbose
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
  echo "Gitleaks detected secrets in the code. Commit rejected."
  exit 1
fi

exit 0
