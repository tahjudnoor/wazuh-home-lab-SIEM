#!/bin/bash
# Wazuh Home Lab - Commands Script
# This file contains all important commands used to set up
# a Wazuh SIEM + File Integrity Monitoring (FIM) lab.
# You can open this file in VS Code, study the commands,
# or run it step-by-step by copying commands into your terminal.

echo "=== Wazuh Home Lab Commands Reference ==="
echo "This script is for reference. Review before running."

###############################################
# 1. Ubuntu – Basic Setup
###############################################

# Update and upgrade packages
sudo apt update -y
sudo apt upgrade -y

# Install basic tools (curl and net-tools for ifconfig)
sudo apt install -y curl net-tools

###############################################
# 2. Add Wazuh GPG Key
###############################################

# Add the Wazuh GPG key (for package verification)
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | \
  sudo gpg --dearmor -o /usr/share/keyrings/wazuh-archive-keyring.gpg

###############################################
# 3. Download and Run Wazuh Installation Script
###############################################

# Download Wazuh installation script
curl -sO https://packages.wazuh.com/4.12/wazuh-install.sh

# Make the script executable
chmod +x wazuh-install.sh

# Run installer (all components, interactive mode)
sudo bash ./wazuh-install.sh -a -i
# -a : install all components (manager, indexer, dashboard)
# -i : interactive mode

###############################################
# 4. Get Ubuntu VM IP Address
###############################################

# Show network interfaces and IP addresses
ifconfig

###############################################
# 5. Manage / Register Wazuh Agent (Ubuntu Side)
###############################################

# Open Wazuh agent manager utility to add/extract agent key
sudo /var/ossec/bin/manage_agents

# Inside the menu:
# A  -> Add agent
# E  -> Extract key
# Q  -> Quit

###############################################
# 6. Useful Wazuh Service Commands (Ubuntu)
###############################################

# Check Wazuh manager status
sudo systemctl status wazuh-manager

# Restart Wazuh manager
sudo systemctl restart wazuh-manager

# Check Wazuh indexer status
sudo systemctl status wazuh-indexer

# Restart Wazuh indexer
sudo systemctl restart wazuh-indexer

###############################################
# 7. Windows Agent – Notes (Not bash commands)
###############################################
# On Windows:
# - Install Wazuh Agent MSI
# - Open "Wazuh Agent Manager"
# - Paste agent key from Ubuntu
# - Enter Manager IP (Ubuntu IP)
# - Save and restart agent

###############################################
# 8. Enable File Integrity Monitoring (Windows)
###############################################
# Edit this file on Windows:
#   C:\Program Files (x86)\ossec-agent\ossec.conf
#
# Add a directory to monitor inside <syscheck>:
#   <directories realtime="yes">C:\Users\YourName\Wazuh-Monitor</directories>
#
# Restart Wazuh service on Windows (CMD as Admin):
#   net stop Wazuh
#   net start Wazuh

echo "=== End of Wazuh Home Lab Commands ==="
