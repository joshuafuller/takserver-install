#!bin/bash

# Remove existing
sudo rm /opt/tak/certs/files/letsencrypt/DOMAIN.p12
sudo rm /opt/tak/certs/files/letsencrypt/DOMAIN.jks

# Create certificates
sudo openssl pkcs12 -export -in /etc/letsencrypt/live/DOMAIN/fullchain.pem -inkey /etc/letsencrypt/live/DOMAIN/privkey.pem -name DOMAIN -out /opt/tak/certs/files/letsencrypt/DOMAIN.p12 -password pass:atakatak
sudo keytool -importkeystore -deststorepass atakatak -destkeystore /opt/tak/certs/files/letsencrypt/DOMAIN.jks -srckeystore /opt/tak/certs/files/letsencrypt/DOMAIN.p12 -srcstoretype PKCS12 -srcstorepass atakatak
yes | sudo keytool -import -alias bundle -trustcacerts -file /etc/letsencrypt/live/DOMAIN/fullchain.pem -keystore /opt/tak/certs/files/letsencrypt/DOMAIN.jks -storepass atakatak

# Modify Permissions to tak:tak
echo "Modifying Permissions of .p12 and .jks"
sudo chown tak:tak /opt/tak/certs/files/letsencrypt/DOMAIN.p12
sudo chown tak:tak /opt/tak/certs/files/letsencrypt/DOMAIN.jks

# Restart Tak Server
echo "restarting tak server"
sudo systemctl restart takserver