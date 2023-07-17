#!/bin/bash
su -m user -l -c "ssh-keygen -q -t rsa -b 1024 -N '' -f /home/user/.ssh/id_rsa"
cp -a /home/user/.ssh/id_rsa.pub /home/user/.ssh/authorized_keys
service ssh start
su -m user -l -c "python3 /opt/app.py"