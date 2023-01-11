#/bin/bash
sudo sed -i '4 i \        <input _name="stdssl" protocol="tls" port="8089"/>' /opt/tak/CoreConfig.xml
sudo sed -i '62d' /opt/tak/CoreConfig.xml
sudo sed -i '62 i \        <tls' /opt/tak/CoreConfig.xml
sudo sed -i '63 i \            keystore="JKS"' /opt/tak/CoreConfig.xml
sudo sed -i '64 i \            keystoreFile="certs/files/DOMAIN.jks"' /opt/tak/CoreConfig.xml
sudo sed -i '65 i \            keystorePass="atakatak"' /opt/tak/CoreConfig.xml
sudo sed -i '66 i \            truststore="JKS"' /opt/tak/CoreConfig.xml
sudo sed -i '67 i \            truststoreFile="certs/files/truststore-ca.DOMAIN.jks"' /opt/tak/CoreConfig.xml
sudo sed -i '68 i \            truststorePass="atakatak"' /opt/tak/CoreConfig.xml
sudo sed -i '69 i \            context="TLSv1.2"' /opt/tak/CoreConfig.xml
sudo sed -i '70 i \            keymanager="SunX509"/>' /opt/tak/CoreConfig.xml
sudo sed -i '73d' /opt/tak/CoreConfig.xml
sudo sed -i '73 i \        <federation-server webBaseUrl="https://DOMAIN:8443/Marti">' /opt/tak/CoreConfig.xml
sudo sed -i '74d' /opt/tak/CoreConfig.xml
sudo sed -i '74 i \            <tls keystore="JKS" keystoreFile="certs/files/DOMAIN.jks" keystorePass="atakatak" truststore="JKS" truststoreFile="certs/files/fed-truststore.jks" truststorePass="atakatak" keymanager="SunX509"/>' /opt/tak/CoreConfig.xml