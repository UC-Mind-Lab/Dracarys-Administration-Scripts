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
sudo -u $username ln -s /tool/xilinx/Xilinx.lic $userhome/.Xilinx/
# Setup ssh folder
sudo -u $username mkdir -p $userhome/.ssh
sudo -u $username touch $userhome/.ssh/authorized_keys
sudo -u $username touch $userhome/.ssh/config
sudo chmod -R g-rwx,o-rwx $userhome/.ssh

# Setup tmux
sudo -u $username git clone https://github.com/gpakosz/.tmux.git $userhome/.tmux
sudo -u $username ln -s -f $userhome/.tmux/.tmux.conf $userhome
sudo -u $username cp $userhome/.tmux/.tmux.conf.local $userhome
echo "echo 'The terminal is better with tmux'" | sudo -u $username tee -a $userhome/.bashrc
echo "echo 'Try it with \"tmux\". Learn it with \"man tmux\" or web searching'" | sudo -u $username tee -a $userhome/.bashrc
echo "echo 'Fancy configs done with \"Oh My Tmux!\"'" | sudo -u $username tee -a $userhome/.bashrc

# Inform them about changing their password
echo "echo 'Change your password with \"passwd\"'" | sudo -u $username tee -a $userhome/.bashrc

# Inform them about how to delete these messages
echo "echo 'Delete this message by editing your ~/.bashrc'" | sudo -u $username tee -a $userhome/.bashrc

# Restrict access to home directory to only the user
sudo chmod -R o-rwx $userhome
