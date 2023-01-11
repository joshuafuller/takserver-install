sleep 2
clear
echo " "
echo "CERTBOT HTTP CHALLENGE"
echo " "

sudo mkdir temp
sleep 1
certbot_http_description1="This script will utilize the HTTP Challenge method to obtain a valid SSL certificate for the takserver"
certbot_http_description2="It is imparative that the domain you specified is publicly routed and point towards this servers public ip address"
certbot_http_decriptions3="Please make sure port 80 and port 443 are forwarded to this machine. If not, the certificate retreval and renew will fail."

printf '%s\n' "$certbot_http_description1" | fold -s
echo " "
printf '%s\n' "$certbot_http_description2" | fold -s
echo " "
printf '%s\n' "$certbot_http_description3" | fold -s
sleep 2

sudo cp getcert-http-raw.sh temp/getcert-http.sh
sudo cp CoreConfig.xml-certsigning-raw.sh temp/CoreConfig.xml-certsigning.sh
sudo cp certbot-jks-raw.sh temp/certbot-jks.sh

cd ..

sudo cp userinputdata/txtfiles/domain.txt certsigning/temp/domain.txt
sudo cp userinputdata/txtfiles/var_organization.txt certsigning/temp/var_organization.txt
sudo cp userinputdata/txtfiles/var_orgunit.txt certsigning/temp/var_orgunit.txt

cd certsigning 

sed -i "s/DOMAIN/$(cat temp/domain.txt)/g" temp/CoreConfig.xml-certsigning.sh
sed -i "s/VAR_ORGANIZATION/$(cat temp/var_organization.txt)/g" temp/CoreConfig.xml-certsigning.sh
sed -i "s/VAR_ORGINIT/$(cat temp/var_orgunit.txt)/g" temp/CoreConfig.xml-certsigning.sh
sed -i "s/DOMAIN/$(cat temp/domain.txt)/g" temp/getcert-http.sh
sed -i "s/DOMAIN/$(cat temp/domain.txt)/g" temp/certbot-jks.sh
sleep 2


echo "We will now attempt to get a certificate from certbot using the HTTP challenge"
echo " "
sleep 1
echo "This will take approximg 90 seconds to complete"
echo " "
sleep 1
echo "Press enter when you are ready to continue..."
while [ true ] ; do
read -t 90 -n 1
if [ $? = 0 ] ; then
sudo bash temp/getcert-http.sh
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