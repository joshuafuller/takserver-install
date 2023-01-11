#!/bin/bash
cd scripts
sudo bash takserver-install.sh

echo " "
echo " "
while true; do
    read -p "Would you like to proceed with the automated takserver setup? (y/n) : " yn
    case $yn in
        [Yy]* ) cd scripts; sudo bash takserver-setup.sh; exit;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done