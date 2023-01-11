clear
sleep 3
echo " "
echo "CERTBOT-CLOUDFLARE API CHALLENGE"
echo " "

sudo mkdir temp
sleep 1
cloudflare_api_description1="To get your cloudflare API KEY, go to cloudflare.com. Then in your profile Click API tokens. Create Custom Token and name it appropriately."
cloudflare_api_description2="Permissions: Zone:DNS:Edit"
cloudflare_api_decriptions3="Zone Resources: Include:Specific zone:<insert root hostname here>"

printf '%s\n' "$cloudflare_api_description1" | fold -s
echo " "
printf '%s\n' "$cloudflare_api_description2" | fold -s
echo " "
printf '%s\n' "$cloudflare_api_description3" | fold -s
sleep 2

echo -n "Please enter your cloudflare API token : "
read -r API_TOKEN
echo "$API_TOKEN" > temp/apitoken.txt
echo " "
sleep 1

sudo cp cloudflare-raw.ini temp/cloudflare.ini
sudo cp getcert-cloudflare-raw.sh temp/getcert-cloudflare.sh
sudo cp CoreConfig.xml-certsigning-raw.sh temp/CoreConfig.xml-certsigning.sh
sudo cp certbot-jks-raw.sh temp/certbot-jks.sh

cd ..

sudo cp userinputdata/txtfiles/domain.txt certsigning/temp/domain.txt
sudo cp userinputdata/txtfiles/var_organization.txt certsigning/temp/var_organization.txt
sudo cp userinputdata/txtfiles/var_orgunit.txt certsigning/temp/var_orgunit.txt

cd certsigning 

sed -i "s/API_TOKEN/$(cat temp/apitoken.txt)/g" temp/cloudflare.ini
sed -i "s/DOMAIN/$(cat temp/domain.txt)/g" temp/CoreConfig.xml-certsigning.sh
sed -i "s/VAR_ORGANIZATION/$(cat temp/var_organization.txt)/g" temp/CoreConfig.xml-certsigning.sh
sed -i "s/VAR_ORGUNIT/$(cat temp/var_orgunit.txt)/g" temp/CoreConfig.xml-certsigning.sh
sed -i "s/DOMAIN/$(cat temp/domain.txt)/g" temp/getcert-cloudflare.sh
sed -i "s/DOMAIN/$(cat temp/domain.txt)/g" temp/certbot-jks.sh
sleep 2

mkdir -p ~/.secrets/certbot/
sudo cp temp/cloudflare.ini ~/.secrets/certbot/cloudflare.ini
sleep 1

sudo chmod 600 ~/.secrets/certbot/cloudflare.ini
echo "We will now attempt to get a certificate from certbot using the API key you entered above"
echo " "
sleep 1
echo "This will take approximg 90 seconds to complete"
echo " "
sleep 1
echo "Press enter when you are ready to continue..."
while [ true ] ; do
read -t 90 -n 1
if [ $? = 0 ] ; then
sudo bash temp/getcert-cloudflare.sh
sleep 2
sudo chmod 775 -R /etc/letsencrypt
sleep 1
sudo mkdir -p /opt/tak/certs/files/letsencrypt
sleep 1
sudo bash temp/certbot-jks.sh 
sleep 1
sudo cp temp/certbot-jks.sh /opt/tak/certs
sleep 1
(sudo crontab -l; echo "0 03 15 * * /opt/tak/certs/certbot-jks.sh")|awk '!x[$0]++'|crontab - 
echo " "
echo "Now modifying the CoreConfig.xml"
echo " "
sleep 2
sudo bash temp/CoreConfig.xml-certsigning.sh
sudo rm -r temp
exit ;
else
echo "waiting for the keypress"
fi
done
