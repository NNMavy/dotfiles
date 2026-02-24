#!/usr/bin/env bash

set -Eeuo pipefail

declare -r DOTFILES_REPO_URL="https://github.com/NNMavy/dotfiles"

function get_os_type() {
  uname
}

function in_wsl() {
  uname -r | grep -qEi "microsoft|wsl"
}

declare ostype="$(get_os_type)"

if [ "${ostype}" == "Linux" ]; then
  # Install Homebrew if necessary
  export HOMEBREW_CASK_OPTS=--no-quarantine
  if which -s brew; then
    echo "Homebrew is already installed."
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  # Install chezmoi if necessary
  if which -s chezmoi; then
    echo "Chezmoi is already installed."
  else
    brew install chezmoi
  fi

  # Install 1Password if necessary
  if which -s op; then
    echo "1Password is already installed."
  else
    if $(in_wsl); then
      # Add 1Password CLI to PATH and create wrapper script for WSL
      echo "PATH=\"$PATH:/mnt/c/Program Files/1Password CLI\"" >> "$HOME/.profile"
      source "$HOME/.profile"
      echo "exec op.exe \"$@\"" >> "$HOME/.local/bin/op"
    else
      brew install 1password-cli
    fi
    read -p "Please open 1Password, log into all accounts and set under Settings>Developer>CLI activate Integrate with 1Password CLI. Press any key to continue." -n 1 -r
  fi
  
  # Apply dotfiles
  echo "Applying Chezmoi configuration."
  chezmoi init NNMavy/dotfiles
  chezmoi apply
fi