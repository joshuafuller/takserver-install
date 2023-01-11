#/bin/bash
clear
sleep 2
echo " "
echo "Generating and moving certs for the TAK Server"
echo " "
sleep 5
sudo mkdir temp
cd ..
sudo cp userinputdata/txtfiles/*.txt internal-certs/temp/
cd internal-certs/
sudo cp cert-metadata-raw.sh temp/cert-metadata.sh
sudo cp MakeCerts-raw.sh temp/MakeCerts.sh
cd temp/
sed -i "s/VAR_STATE/$(cat var_state.txt)/g" cert-metadata.sh
sed -i "s/VAR_CITY/$(cat var_city.txt)/g" cert-metadata.sh
sed -i "s/VAR_ORGANIZATION/$(cat var_organization.txt)/g" cert-metadata.sh
sed -i "s/VAR_ORGUNIT/$(cat var_orgunit.txt)/g" cert-metadata.sh
sed -i "s/DOMAIN/$(cat domain.txt)/g" MakeCerts.sh
sudo cp cert-metadata.sh /opt/tak/certs
sleep 5
sudo bash MakeCerts.sh
sleep 5
echo " "
echo " "
echo "Complete!"
sleep 5
cd ..
echo "Press enter when you are ready to continue..."
while [ true ] ; do
read -t 90 -n 1
if [ $? = 0 ] ; then
echo "Removing temp files"
sleep 2
sudo rm -r temp && clear
exit ;
else
echo "waiting for the keypress"
fi
done
