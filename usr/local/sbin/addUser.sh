#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <new_user_name>"
  exit 1
fi
username=$1

if [ "$EUID" -ne 0 ]; then
  echo "$0 must be run as root"
  exit 2
fi

# Create the user
sudo adduser $username
# Expire and lock their password
sudo passwd -e -l $username

# Groups they should be added to
sudo adduser $username libvirt # For KVM acceleration for AndroidStudio
sudo adduser $username kvm # For access to KVM for AndroidStudio
sudo adduser $username MindLabMember # For access to the public folder

userhome=/home/$username
# Add a symbolic link to the public folder
sudo -u $username ln -s /home/MindLabMember $userhome/Public
# Set up link to Android SDK
sudo -u $username mkdir -p $userhome/Android
sudo -u $username ln -s /home/MindLabMember/Android/Sdk $userhome/Android/
# Set up Xilinx
sudo -u $username mkdir -p $userhome/.Xilinx
sudo -u $username ln -s /opt/xilinx/Xilinx.lic $userhome/.Xilinx/
# Set ssh folder
sudo -u $username mkdir -p $userhome/.ssh
sudo -u $username touch $userhome/.ssh/authorized_keys
sudo -u $username touch $userhome/.ssh/config
sudo chmod -R g-rwx,o-rwx $userhome/.ssh

