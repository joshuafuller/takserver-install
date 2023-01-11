clear
sleep 2
echo " "
echo "TAKSERVER VANILLA SETUP"
echo " "

sudo mkdir temp
sleep 1
vanilla_setup_description1="This script will utilize the only self signed certificates and requires certificates be generated and distributed manually to each client"
vanilla_setup_description2="Please check under /opt/tak/CLIENT_PACKAGES for scripts to generate certificate bundles and configs for ATAK, WinTAK, and iTAK"

printf '%s\n' "$vanilla_setup_description1" | fold -s
echo " "
printf '%s\n' "$vanilla_setup_description2" | fold -s
sleep 2

sudo cp CoreConfig.xml-vanilla-raw.sh temp/CoreConfig.xml-vanilla.sh

cd ..

sudo cp userinputdata/txtfiles/domain.txt selfsigned/temp/domain.txt

cd selfsigned 

sed -i "s/DOMAIN/$(cat temp/domain.txt)/g" temp/CoreConfig.xml-vanilla.sh
sleep 2

echo " "
echo "We will now modify and setup the CoreConfig.xml file for use with the self signed certificates"
echo " "
sleep 1
echo "Press enter when you are ready to continue..."
while [ true ] ; do
read -t 90 -n 1
if [ $? = 0 ] ; then
echo " "
echo "Now modifying the CoreConfig.xml"
echo " "
sleep 2
sudo bash temp/CoreConfig.xml-vanilla.sh
sudo rm -r temp
exit ;
else
echo "waiting for the keypress"
fi
done