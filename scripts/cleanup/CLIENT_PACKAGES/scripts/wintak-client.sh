clear
sleep 2
echo " "
echo " "
echo "GENERATING WINTAK CLIENT ZIP"
echo " "
echo " "
sleep 2
sudo mkdir -p temp/txtfiles
echo -n "What is the client name? : "
read -r CLIENT_CERT
echo "$CLIENT_CERT" > temp/txtfiles/client_cert.txt
echo " "
sleep 2
echo "Creating new user"
sleep 2
sudo cp UserManager-raw.sh temp/UserManager.sh
sudo cp MakeCert-raw.sh temp/MakeCert.sh
sudo cp CopyCerts-wintak-raw.sh temp/CopyCerts-wintak.sh
sudo cp move-zip-wintak-raw.sh temp/move-zip-wintak.sh
sudo cp -r WINTAK-CLIENT-RAW temp/WINTAK-CLIENT
sleep 2
USERPASSWORD=$(pwgen -Bcnv 15 1)
echo "TAK!-$USERPASSWORD" >> temp/txtfiles/userpassword.txt
sed -i "s/USERPASSWORD/$(cat temp/txtfiles/userpassword.txt)/g" temp/UserManager.sh
sleep 1
sed -i "s/CLIENT_CERT/$(cat temp/txtfiles/client_cert.txt)/g" temp/UserManager.sh
sed -i "s/CLIENT_CERT/$(cat temp/txtfiles/client_cert.txt)/g" temp/MakeCert.sh
sed -i "s/CLIENT_CERT/$(cat temp/txtfiles/client_cert.txt)/g" temp/CopyCerts-wintak.sh
sed -i "s/CLIENT_CERT/$(cat temp/txtfiles/client_cert.txt)/g" temp/move-zip-wintak.sh
sed -i "s/CLIENT_CERT/$(cat temp/txtfiles/client_cert.txt)/g" temp/WINTAK-CLIENT/certs/CREN.pref
sed -i "s/CLIENT_CERT/$(cat temp/txtfiles/client_cert.txt)/g" temp/WINTAK-CLIENT/MANIFEST/manifest.xml
RANDOM_UID=$(pwgen -Ans 32 1)
echo "$RANDOM_UID" >> temp/txtfiles/random_uid.txt
sed -i "s/RANDOM_UID/$(cat temp/txtfiles/random_uid.txt)/g" temp/WINTAK-CLIENT/MANIFEST/manifest.xml
sleep 5
sudo bash temp/UserManager.sh
sleep 10
sudo bash temp/MakeCert.sh
sleep 5
sudo bash temp/CopyCerts-wintak.sh
sleep 2
cd temp/WINTAK-CLIENT
sudo zip -r WINTAK-CLIENT.zip certs MANIFEST Maps Plugins
cd /opt/tak/CLIENT_PACKAGES/scripts
echo "Cleaing up files"
sudo bash temp/move-zip-wintak.sh
sleep 3
sudo rm -r temp
echo "Complete!"
sleep 2