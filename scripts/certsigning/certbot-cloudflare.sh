echo "$API_TOKEN" > temp/apitoken.txt
echo " "
sleep 1

sudo cp cloudflare-raw.ini temp/cloudflare.ini
sudo cp getcert-cloudflare-raw.sh temp/getcert-cloudflare.sh
sudo cp CoreConfig.xml-certsigning-raw.sh temp/CoreConfig.xml-certsigning.sh
sudo cp certbot-jks-raw.sh temp/certbot-jks.sh
sudo cp autorenwal-raw.sh temp/autorenewal.sh

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
sed -i "s/FQDN/$(cat temp/domain.txt)/g" temp/autorenewal.sh
sleep 2

mkdir -p ~/.secrets/certbot/
sudo cp temp/cloudflare.ini ~/.secrets/certbot/cloudflare.ini
sleep 1

sudo chmod 600 ~/.secrets/certbot/cloudflare.ini
echo "We will now attempt to get a certificate from certbot using the API key you entered above"
echo " "
sleep 1
echo "This will take approximately 90 seconds to complete"
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
sudo cp temp/autorenwal.sh /opt/tak/certs
sudo chmod +x /opt/tak/certs/autorenewal.sh
sleep 1
echo " "
echo "Creating cronjob for Autorenewal of Certs"
echo " "
sleep 1
sudo bash crontab.sh
sleep 1
echo " "
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
