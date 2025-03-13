#!/bin/bash

LIGHT_BLUE='\033[1;34m'
NC='\033[0m'

describe_step () {
  echo -e "\n${LIGHT_BLUE}~~~${NC} $1 ${LIGHT_BLUE}~~~${NC}"
}

# ------------------------------------------------------------------------------
# Verify that xcode-select is installed
# ------------------------------------------------------------------------------
describe_step "Verify that xcode-select is installed."
xcode-select -p > /dev/null
if [[ $? != 0 ]] ; then
  echo -e "xcode-select is not installed, installing."
  xcode-select --install
else
  echo -e "xcode-select already installed, skipping."
fi

# ------------------------------------------------------------------------------
# Install, or update, Homebrew
# ------------------------------------------------------------------------------
which -s brew
if [[ $? != 0 ]] ; then
  # Install Homebrew
  describe_step "Homebrew not installed. Installing."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  # Homebrew already intalled, update
  describe_step "Homebrew already installed. Attempts updating."
  brew update
fi

# ------------------------------------------------------------------------------
# Install, or upgrade, Ansible via Homebrew
# ------------------------------------------------------------------------------
describe_step "Checking Ansible package status."

ansible_is_installed=`brew list | grep "ansible"`
if [[ -z "$ansible_is_installed" ]]; then
  echo -e "Ansible package is not installed. Installing...\n"
  brew install ansible
  exit 0
fi

ansible_is_outdated=`brew outdated | grep "ansible"`
if [[ -z "$ansible_is_outdated" ]]; then
  echo -e "Ansible package is installed, but does not need upgrading.\n"
else
  echo -e "Ansible package is installed, but an updated version exist. Upgrading...\n"
  brew upgrade ansible
fi
