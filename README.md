## **TAK-Server Installation Script**
!! UNDER DEVELOPMENT !!

Fully automated installation and provisioning of takserver 4.8 RELEASE31 on Ubuntu

> **NOTE:** Installation script has been tested and assumes you are using Ubuntu 20.04 LTS and Cloudflare for public DNS. Some functions of the script allow for non public certificate configuration or obtaining public certs via certbot by http/s challenge. This has not been fully tested.

This script assumes you have a working knowledge of the TAK software suite and basic linux commands. This repository does not contain any packages for any TAK related product. Therefore, you must obtain and merge those packages within this cloned repository through tak.gov. This script assumes you are utilizing a 'single-server' installation.

## 1. Clone Repository
Clone this repository in your user's home directory

    sudo apt install git -y
    cd
    git clone https://github.com/tstechnologies/takserver-install.git

## 1.1. Download and transfer software package, policy, and key from TAK.gov
**FILES TO OBTAIN:**
takserver_4.8-RELEASE31_all.deb
deb_policy.pol
taskerver-public-gpg.key

Place the downloaded files in the ROOT of this cloned repository.

    EXAMPLE PATH: 
    /home/user/takserver-install/takserver_4.8-RELEASE31_all.deb
    /home/user/takserver-install/deb_policy.pol
    /home/user/takserver-install/taskerver-public-gpg.key
    

> **EXAMPLE SCP:** via windows cmd, terminal, etc..

    scp C:\Users\$WIN-USER\Downloads\takserver_4.8-RELEASE31_all.deb $UBUNTU-USER@192.168.0.1:/home/$UBUNTU-USER/takserver-install

## 2. Start Script and Install TAK server
On ubuntu machine change directory into cloned repository

    cd takserver-install
Start script and follow prompts closely:

    sudo bash start.sh
    
## 3. Networking
FQDN's must point and be portforwarded on 8089 and 8446 (TCP) for basic operation of the server. Please refer to the TAK documentation for use of additional ports and federation.

Web admin can be reached at https://DOMAIN:8446

> **NOTE FOR UBUNTU FIREWALL**

If using ubuntu wth a gui or firewall enabled (ufw is default in 20.04 and typically enabled on VPS's). UFW status can be verified by command:
    
    sudo ufw status

If enabled add following ports at minimum for external access:

    sudo ufw allow 8446/tcp #certificate enrollment port
    sudo ufw allow 8089/tcp #TAK TLS connector
    sudo ufw allow 22/tcp #SSH access to machine

## 4. End User Device Certificate Enrollment
### 4.1 ATAK (Android)
When attempting to connect to the takserver with certificate enrollment, you can "add a server" in ATAK or use the Quick Connect feature.  If using the "add server", the following information will be needed:
1. Name: \[User Supplied\]
2. URL:  DOMAIN
3. Check "Enroll for Client Certficate" 
	> **DO NOT CHECK "Use Authentication" for flat file authentication** (other authentication methods may require it such as LDAP, etc).

If Using the Quick Connect option, you just need the address (DOMAIN) and the user credentials created TAK Server using the CLI or using the User-Management interface.

### 4.2 iTAK (iOS)
iTAK has two ways to utilize certificate enrollment - adding the server manually or by QR Code.  The information needed for either approach is:
1. Name: `\[User Supplied\]`
2. URL: `DOMAIN`
3. Port:  `8089` (unless you have specified otherwise)
4. Protocol:  `SSL`

## REPOSITORY NOTES

Automatic certificate renewal has not been fully implemented.
For now, you will need to renew and convert the public SSL cert prior to its expiration. This can be done via an embeded script in the repository.
> Would like to modify and add this as a cronjob in the future setup by this install script

**Renewal Script POST install**

    sudo bash /opt/tak/certs/certbot-jks.sh
    sudo systemctl restart takserver
    
Need to add script to increase memory usage and buffer on postgresql
