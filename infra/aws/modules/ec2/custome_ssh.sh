#!/bin/bash

apt-get update -y && apt-get upgrade -y
sed -i 's/#Port 22/Port 8008/' /etc/ssh/sshd_config
systemctl restart sshd
systemctl enable sshd

