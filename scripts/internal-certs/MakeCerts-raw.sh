#/bin/bash
cd /opt/tak/certs
sudo bash makeRootCa.sh --ca-name root.DOMAIN
yes | sudo bash makeCert.sh ca ca.DOMAIN
sudo bash makeCert.sh server DOMAIN