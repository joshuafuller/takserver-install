#!/bin/bash
clear
sleep 2
echo " "
echo " "
echo "!!!--UNDER DEVELOPMENT--!!!"
echo " "
echo "Welcome to the automated tak server setup!"
echo " "
echo " "
sleep 2
takserver_setup_description1="The following script will install and prompt you for several inputs in order to setup a fully functional tak server"
takserver_setup_description2="At this time the script does not validate any of your inputs. Therefore, if a mistake is made you will need to wipe and start with a fresh install of Ubuntu/Debian in order to effectively use this script again"
takserver_setup_description3="Please read and enter data carefully"
printf '%s\n' "$takserver_setup_description1" | fold -s
echo " "
printf '%s\n' "$takserver_setup_description2" | fold -s
echo " "
printf '%s\n' "$takserver_setup_description3" | fold -s
echo " "
echo " "
sleep 2
while true; do
    read -p "Are you ready to continue? (y/n) : " yn
    case $yn in
        [Yy]* ) cd userinputdata; sudo bash data-collection.sh; cd ..; cd internal-certs; sudo bash cert-gen.sh; cd ..; clear;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
    read -p "Will you be using publicly signed SSL certs and certsigning? (y/n) : " yn
    case $yn in
        [Yy]* ) cd certsigning; sudo bash cert-setup-letsencrypt.sh; cd ..; clear; cd cleanup; sudo bash cleanupinstall.sh; cd ..; exit;;
        [Nn]* ) cd selfsigned; sudo bash selfsigned-setup.sh; cd ..; clear; cd cleanup; sudo bash cleanupinstall.sh; cd ..; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
