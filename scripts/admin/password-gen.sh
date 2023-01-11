#!/bin/bash
ADMINPASSWORD=$(pwgen -Bcnv 15 1)
echo "TAK!-$ADMINPASSWORD" >> adminpassword.txt
sed -i "s/ADMINPASSWORD/$(cat adminpassword.txt)/g" tak-admin.sh