#!/bin/bash

mkdir -p /tmp/aws-cli-v2
cd /tmp/aws-cli-v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
apt-get -y update >/tmp/update.log
apt-get install -y sudo >/tmp/sudo.log
sudo ./aws/install --update
cd -
/usr/local/bin/aws --version

echo "Copying /usr/local/bin/aws to /bin"
ln -s /usr/local/bin/aws /bin/aws
/bin/aws --version
