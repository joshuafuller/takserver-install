#!/bin/bash
clear
echo "Updating System"
sleep 2
echo " "
echo " "
sudo apt update
echo " "
echo " "
sleep 2
echo "Upgrading System"
sleep 2
echo " "
echo " "
yes | sudo apt upgrade -y

# --- #

echo "Changing Security Limits"
sleep 5
echo " "
echo " "
echo -e "* soft nofile 32768\n* hard nofile 32768" | sudo tee --append /etc/security/limits.conf > /dev/null
echo " "
echo " "

# --- #

echo "Installing postgres, pwgen, and zip"
sleep 5
echo " "
echo " "
yes | sudo curl -fsSo /etc/apt/trusted.gpg.d/pgdg.asc https://www.postgresql.org/media/keys/ACCC4CF8.asc
echo " "
sleep 5
yes | sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
sleep 5
sudo apt update
sleep 5
yes | sudo apt update
echo " "
echo " "
sleep 1
yes | sudo apt install pwgen -y
sleep 5
yes | sudo apt install zip -y

# --- #

sleep 5
echo "Verifying GPG signatures for DEB packages"
sleep 2
yes | sudo apt install debsig-verify -y
sleep 2
echo " "
echo " "
cd ..
sudo mkdir -p /usr/share/debsig/keyrings/F06237936851F5B5
sudo mkdir -p /etc/debsig/policies/F06237936851F5B5
sudo touch /usr/share/debsig/keyrings/F06237936851F5B5/debsig.gpg
sudo gpg --no-default-keyring --keyring /usr/share/debsig/keyrings/F06237936851F5B5/debsig.gpg --import takserver-public-gpg.key
sudo cp deb_policy.pol /etc/debsig/policies/F06237936851F5B5/debsig.pol
echo " "
debsig-verify -v takserver_4.8-RELEASE31_all.deb
sleep 3

# --- #

echo "Installing TAK Server"
echo " "
sleep 5
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install ./takserver_4.8-RELEASE31_all.deb 
echo " "
echo " "

# --- #

echo "Setting up database"
echo " "
sleep 5
sudo /opt/tak/db-utils/takserver-setup-db.sh
echo " "
echo " "

# --- #

echo "Enabiling the server"
echo " "
sleep 5
sudo systemctl daemon-reload
sleep 5
sudo systemctl start takserver
sleep 5
sudo systemctl enable takserver
sleep 5
sudo systemctl status takserver --no-pager
sleep 10
echo " "
echo " "

# --- #

echo "All done!"
sleep 2

# --- #
