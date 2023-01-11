#!/bin/bash
clear
sleep 3
echo " "
echo "Please follow the instructions below carefully"
echo " "
sleep 2
echo "The follwing will prompt you for inputs that are critical"
echo "for a successful TAK server deployment."
echo " "
sleep 2
echo "Regardless of having a fully qualified domain (FQDN) that is publicly routable"
echo "You must define a domain name in order for the server to properly authenticate"
echo "clients."
echo " "
sleep 2
echo "If you do have a FQDN and are going to be using letsencrypt or another publicly recognized"
echo "server certificate, be sure the FQDN matches exactly with the certificate name"
echo " "
sleep 2
echo "Wildcard certificates will not work with TAK server at this time."
echo " "
sleep 2
echo "The bellow fields are non validating, meaning they will accept any input you place into them."
echo "Prior to procceding with the rest of the server installation  you will be given an option to"
echo "proceed with the rest of the install after a printout of the below fields are displayed"
echo " "
sleep 5
sudo mkdir txtfiles
echo -n "What State is this server located in? : "
read -r VAR_STATE
echo "$VAR_STATE" > txtfiles/var_state.txt
echo " "
sleep 2
echo -n "What City is this server located in? : "
read -r VAR_CITY
echo "$VAR_CITY" > txtfiles/var_city.txt
echo " "
sleep 2
echo -n "What is your orginizations name? : "
read -r VAR_ORGANIZATION
echo "$VAR_ORGANIZATION" > txtfiles/var_organization.txt
echo " "
sleep 2
echo -n "What is your units name? (IE: SPECIAL OPERATIONS) : "
read -r VAR_ORGUNIT
echo "$VAR_ORGUNIT" > txtfiles/var_orgunit.txt
echo " "
sleep 2
echo -n "What is this servers FQDN (IE: tak.example.com) : "
read -r DOMAIN
echo "$DOMAIN" > txtfiles/domain.txt
sleep 5
clear
state=$(cat txtfiles/var_state.txt)
city=$(cat txtfiles/var_city.txt)
organization=$(cat txtfiles/var_organization.txt)
orgunit=$(cat txtfiles/var_orgunit.txt)
domain=$(cat txtfiles/domain.txt)
sleep 2
echo "Below are the following parameters that will be used to provision the TAK Server"
echo " "
echo " "
echo "The following Cert-Metadata will be used:"
echo "COUNTRY = US"
echo "STATE = $state"
echo "CITY = $city"
echo "ORGANIZATION = $organization"
echo "ORGINZATIONAL_UNIT = $orgunit"
echo " "
echo "Takserver FQDN: $domain"
sleep 5
echo " "
echo " "
while true; do
    read -p "Is the above info correct? (y/n) : " yn
    case $yn in
        [Yy]* ) clear; exit;;
        [Nn]* ) sudo rm -r txtfiles; sudo bash data-collection.sh; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
