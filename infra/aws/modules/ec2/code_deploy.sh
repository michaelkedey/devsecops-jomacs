#!/bin/bash
sudo apt update
sudo apt install -y ruby
wget https://aws-codedeploy-${AWS_REGION}.s3.${AWS_REGION}.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto