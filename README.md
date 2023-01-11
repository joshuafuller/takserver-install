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
