#!/bin/bash
clear
sleep 2
echo " "
echo " "
echo "Cleaning up TAKSERVER install"
echo " "
echo " "
sleep 2
sudo mkdir temp
cd ..
sudo cp userinputdata/txtfiles/domain.txt cleanup/temp
sudo cp userinputdata/txtfiles/var_organization.txt cleanup/temp
cd cleanup
sed -i "s/DOMAIN/$(cat temp/domain.txt)/g" CLIENT_PACKAGES/scripts/ATAK-CLIENT-RAW/MANIFEST/manifest.xml
sed -i "s/DOMAIN/$(cat temp/domain.txt)/g" CLIENT_PACKAGES/scripts/ATAK-CLIENT-RAW/certs/CREN.pref
sed -i "s/VAR_ORGANIZATION/$(cat temp/var_organization.txt)/g" CLIENT_PACKAGES/scripts/ATAK-CLIENT-RAW/MANIFEST/manifest.xml
sed -i "s/VAR_ORGANIZATION/$(cat temp/var_organization.txt)/g" CLIENT_PACKAGES/scripts/ATAK-CLIENT-RAW/certs/CREN.pref
sleep 1
sed -i "s/DOMAIN/$(cat temp/domain.txt)/g" CLIENT_PACKAGES/scripts/ITAK-CLIENT-RAW/manifest.xml
sed -i "s/DOMAIN/$(cat temp/domain.txt)/g" CLIENT_PACKAGES/scripts/ITAK-CLIENT-RAW/CREN.pref
sed -i "s/VAR_ORGANIZATION/$(cat temp/var_organization.txt)/g" CLIENT_PACKAGES/scripts/ITAK-CLIENT-RAW/manifest.xml
sed -i "s/VAR_ORGANIZATION/$(cat temp/var_organization.txt)/g" CLIENT_PACKAGES/scripts/ITAK-CLIENT-RAW/CREN.pref
sleep 1
sed -i "s/DOMAIN/$(cat temp/domain.txt)/g" CLIENT_PACKAGES/scripts/WINTAK-CLIENT-RAW/MANIFEST/manifest.xml
sed -i "s/DOMAIN/$(cat temp/domain.txt)/g" CLIENT_PACKAGES/scripts/WINTAK-CLIENT-RAW/certs/CREN.pref
sed -i "s/VAR_ORGANIZATION/$(cat temp/var_organization.txt)/g" CLIENT_PACKAGES/scripts/WINTAK-CLIENT-RAW/MANIFEST/manifest.xml
sed -i "s/VAR_ORGANIZATION/$(cat temp/var_organization.txt)/g" CLIENT_PACKAGES/scripts/WINTAK-CLIENT-RAW/certs/CREN.pref
sleep 1
sed -i "s/DOMAIN/$(cat temp/domain.txt)/g" CLIENT_PACKAGES/scripts/CopyCerts-itak-raw.sh
sed -i "s/DOMAIN/$(cat temp/domain.txt)/g" CLIENT_PACKAGES/scripts/CopyCerts-atak-raw.sh
sed -i "s/DOMAIN/$(cat temp/domain.txt)/g" CLIENT_PACKAGES/scripts/CopyCerts-wintak-raw.sh
sleep 1
sudo cp -r CLIENT_PACKAGES /opt/tak/
sleep 1
sudo rm -r temp
sleep 2
echo "Restarting the service"
echo " "
sleep 5
sudo systemctl daemon-reload
sleep 5
sudo systemctl restart takserver
sleep 5
sudo systemctl status takserver --no-pager
sleep 3
echo " "
echo " "
sleep 2
echo "Complete!"
echo " "
echo " "
sleep 2
cd ..
while true; do
    read -p "Would you like to setup the admin user? (y/n) : " yn
    case $yn in
        [Yy]* ) clear; cd admin; sudo bash gen-admin.sh; cd ..; echo "Now exiting..."; sleep 5; clear; exit;; 
        [Nn]* ) echo "Now exiting..."; sleep 5; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done