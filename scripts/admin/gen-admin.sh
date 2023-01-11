#!/bin/bash
clear
sleep 3
echo " "
echo " "
echo "GENERATE TAK ADMIN"
echo " "
echo " "
sleep 15
sudo mkdir ./temp
sudo cp password-gen.sh ./temp/password-gen.sh
sudo cp tak-admin-raw.sh ./temp/tak-admin.sh
cd temp
sudo bash password-gen.sh
sleep 5
sudo bash tak-admin.sh
sleep 5
sudo bash tak-admin.sh
passwrd=$(cat adminpassword.txt)
echo " "
echo "TAK Admin User Created"
echo " "
sleep 2
echo "Credentials for server are below. You can change this in the web portal or by"
echo "runnining the following command:"
echo " "
echo "sudo java -jar /opt/tak/utils/UserManager.jar usermod -A -p <CHANGEME> admin"
echo " "
echo "Password must be a minimum of 15 characters including 1 uppercase," 
echo "1 lowercase, 1 number, and 1 special character"
sleep 2
echo " "
echo "Please take a moment to copy or write these down"
echo " "
echo " "
echo "Username: admin"
echo "Password: $passwrd"
echo " "
cd ..
sleep 5
echo "Press enter when you are ready to continue..."
while [ true ] ; do
read -t 90 -n 1
if [ $? = 0 ] ; then
echo "Removing temporary files"
sleep 5
sudo rm -r temp/ && clear
echo "TAK SERVER INSTALL COMPLETE"
sleep 5
exit ;
else
echo "waiting for the keypress"
fi
done
