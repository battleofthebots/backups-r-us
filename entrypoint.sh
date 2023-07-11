#!/bin/bash
su -m user -l -c "ssh-keygen -q -t rsa -b 1024 -N '' -f /home/user/.ssh/id_rsa"
cp /home/user/.ssh/id_rsa.pub /home/user/.ssh/authorized_keys
PASSWORD=$(sed -n "$((RANDOM%512))p" < /usr/share/wordlists/rockyou.txt)
mkdir -p /var/www/backups
zip -r /var/www/backups/home.zip /home/user -P=$PASSWORD

service ssh start
su -m user -l -c "python3 /opt/app.py"