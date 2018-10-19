#!/bin/bash

LIGHT_BLUE='\033[1;34m'
NC='\033[0m'

# Install "Homebrew" if not already installed, otherwise update.
which -s brew
if [[ $? != 0 ]] ; then
  # Install Homebrew
  echo -e "\n${LIGHT_BLUE}~~~${NC} Homebrew not intalled, installing...${LIGHT_BLUE}~~~${NC}\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  # Homebrew already intalled, update
  echo -e "\n${LIGHT_BLUE}~~~${NC} Homebrew already installed, attempts updating instead... ${LIGHT_BLUE}~~~${NC}\n"
  brew update
fi

# Install Ansible via Homebrew if not already installed, otherwise upgrade.
echo -e "\n${LIGHT_BLUE}~~~${NC} Checking Ansible package status ${LIGHT_BLUE}~~~${NC}\n"
ansible_is_installed=`brew list | grep "ansible"`
ansible_is_outdated=`brew outdated | grep "ansible"`

if [[ ! -z "$ansible_is_installed" ]]; then
    if [[ -z "$ansible_is_outdated" ]]; then
        echo -e "Ansible package is installed, but does not need updating.\n"
    else
        echo -e "Ansible package is installed, but an updated version exist. Updating...\n"
        brew upgrade ansible
    fi
else
    echo -e "Ansible package is not installed. Installing...\n"
    brew install ansible
fi