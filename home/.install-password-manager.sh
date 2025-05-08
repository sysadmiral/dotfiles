#!/bin/bash

set -eux -o pipefail

set +x

# exit immediately if password-manager-binary is already in $PATH
hash op 2> /dev/null && exit

case "$(uname -s)" in
Darwin)
  # commands to install password-manager-binary on Darwin
  ;;
Linux)
  case "$(grep ^ID /etc/os-release | cut -d\= -f2)" in
  debian)
    # Add the key for the 1Password apt repository
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
      sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg --yes
    # Add the 1Password apt repository
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | sudo tee /etc/apt/sources.list.d/1password.list
    # Add the debsig-verify policy
    sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
    curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | \
      sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
    sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
      sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg --yes
    # Install 1Password CLI
    sudo apt update && sudo apt install --assume-yes 1password-cli
    ;;
  *)
    echo "failed to detect Linux distro in 1password install script"
    exit 1
    ;;
  esac
  ;;
*)
  echo "missing OS in 1password install script"
  exit 1
  ;;
esac
