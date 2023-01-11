#/bin/bash
clear
sleep 5
echo " "
echo " "
echo "CERTBOT-LETSENCRYPT TAKSERVER SETUP"
echo " "
echo " "
sleep 5
echo "Installing Certbot with Cloudflare Plugin"
sleep 2
yes | sudo apt install snapd -y
sleep 2
sudo snap install core; sudo snap refresh core
sleep 2
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo snap set certbot trust-plugin-with-root=ok
sudo snap install certbot-dns-cloudflare
sleep 5
echo " "
while true; do
    read -p "Will you be using a cloudflares API to obtain ssl certificates? (y/n) : " yn
    case $yn in
        [Yy]* ) sudo bash certbot-cloudflare.sh; exit;;
        [Nn]* ) sudo bash certbot-web.sh; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done