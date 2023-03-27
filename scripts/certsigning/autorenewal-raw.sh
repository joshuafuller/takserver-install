#!/bin/bash

# Set the domain name
domain=FQDN

# Set the log file path
log_file=/var/log/certbot_renewal.log

# Check if the certificate has been renewed by certbot
certbot_has_renewed=$(sudo certbot certificates | grep "$domain" | grep "Renew" | wc -l)

if [ $certbot_has_renewed -gt 0 ]; then
    # Renew the certificate
    sudo rm /opt/tak/certs/files/letsencrypt/$domain.p12
    sudo rm /opt/tak/certs/files/letsencrypt/$domain.jks

    # Create certificates
    sudo openssl pkcs12 -export -in /etc/letsencrypt/live/$domain/fullchain.pem -inkey /etc/letsencrypt/live/$domain/privkey.pem -name $domain -out /opt/tak/certs/files/letsencrypt/$domain.p12 -password pass:atakatak
    sudo keytool -importkeystore -deststorepass atakatak -destkeystore /opt/tak/certs/files/letsencrypt/$domain.jks -srckeystore /opt/tak/certs/files/letsencrypt/$domain.p12 -srcstoretype PKCS12 -srcstorepass atakatak
    yes | sudo keytool -import -alias bundle -trustcacerts -file /etc/letsencrypt/live/$domain/fullchain.pem -keystore /opt/tak/certs/files/letsencrypt/$domain.jks -storepass atakatak

    # Modify Permissions to tak:tak
    echo "Modifying Permissions of .p12 and .jks"
    sudo chown tak:tak /opt/tak/certs/files/letsencrypt/$domain.p12
    sudo chown tak:tak /opt/tak/certs/files/letsencrypt/$domain.jks

    # Restart Tak Server
    sudo systemctl restart takserver

    # Log success message to file
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Successfully renewed certificate for $domain" >> $log_file
else
    # Log no action message to file
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Certificate for $domain not due for renewal" >> $log_file
fi
