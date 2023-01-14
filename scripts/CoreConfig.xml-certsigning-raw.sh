#/bin/bash
sudo sed -i '4 i \        <input _name="stdssl" protocol="tls" port="8089"/>' /opt/tak/CoreConfig.xml
sudo sed -i '10d' /opt/tak/CoreConfig.xml
sudo sed -i '10 i \        <connector port="8446" clientAuth="false" _name="cert_https" keystore="JKS" keystoreFile="certs/files/letsencrypt/DOMAIN.jks" keystorePass="atakatak" truststore="JKS" truststoreFile="certs/files/truststore-ca.DOMAIN.jks" truststorePass="atakatak"/>' /opt/tak/CoreConfig.xml
sudo sed -i '61 i \    <certificateSigning CA="TAKServer">' /opt/tak/CoreConfig.xml
sudo sed -i '62 i \        <certificateConfig>' /opt/tak/CoreConfig.xml
sudo sed -i '63 i \            <nameEntries>' /opt/tak/CoreConfig.xml
sudo sed -i '64 i \                <nameEntry name="O" value="VAR_ORGANIZATION"/>' /opt/tak/CoreConfig.xml
sudo sed -i '65 i \                <nameEntry name="OU" value="VAR_ORGUNIT"/>' /opt/tak/CoreConfig.xml
sudo sed -i '66 i \            </nameEntries>' /opt/tak/CoreConfig.xml
sudo sed -i '67 i \        </certificateConfig>' /opt/tak/CoreConfig.xml
sudo sed -i '68 i \        <TAKServerCAConfig' /opt/tak/CoreConfig.xml
sudo sed -i '69 i \            keystore="JKS"' /opt/tak/CoreConfig.xml
sudo sed -i '70 i \            keystoreFile="certs/files/ca.DOMAIN-signing.jks"' /opt/tak/CoreConfig.xml
sudo sed -i '71 i \            keystorePass="atakatak"' /opt/tak/CoreConfig.xml
sudo sed -i '72 i \            signatureAlg="SHA256WithRSA"' /opt/tak/CoreConfig.xml
sudo sed -i '73 i \            CAkey="/opt/tak/certs/files/ca.DOMAIN"' /opt/tak/CoreConfig.xml
sudo sed -i '74 i \            CAcertificate="/opt/tak/certs/files/ca.DOMAIN"/>' /opt/tak/CoreConfig.xml
sudo sed -i '75 i \    </certificateSigning>' /opt/tak/CoreConfig.xml
sudo sed -i '77d' /opt/tak/CoreConfig.xml
sudo sed -i '77 i \        <tls' /opt/tak/CoreConfig.xml
sudo sed -i '78 i \            keystore="JKS"' /opt/tak/CoreConfig.xml
sudo sed -i '79 i \            keystoreFile="certs/files/DOMAIN.jks"' /opt/tak/CoreConfig.xml
sudo sed -i '80 i \            keystorePass="atakatak"' /opt/tak/CoreConfig.xml
sudo sed -i '81 i \            truststore="JKS"' /opt/tak/CoreConfig.xml
sudo sed -i '82 i \            truststoreFile="certs/files/truststore-DOMAIN.jks"' /opt/tak/CoreConfig.xml
sudo sed -i '83 i \            truststorePass="atakatak"' /opt/tak/CoreConfig.xml
sudo sed -i '84 i \            context="TLSv1.2"' /opt/tak/CoreConfig.xml
sudo sed -i '85 i \            keymanager="SunX509"/>' /opt/tak/CoreConfig.xml
sudo sed -i '88d' /opt/tak/CoreConfig.xml
sudo sed -i '88 i \        <federation-server webBaseUrl="https://DOMAIN:8443/Marti">' /opt/tak/CoreConfig.xml
sudo sed -i '89d' /opt/tak/CoreConfig.xml
sudo sed -i '89 i \            <tls keystore="JKS" keystoreFile="certs/files/DOMAIN.jks" keystorePass="atakatak" truststore="JKS" truststoreFile="certs/files/fed-truststore.jks" truststorePass="atakatak" keymanager="SunX509"/>' /opt/tak/CoreConfig.xml
