#!/bin/bash
echo "Make Setup.sh executable"

chmod u+x setup.sh

echo "Create Directory for Prometheus"

mkdir prometheus

echo "apt update ubuntu"

sudo apt-get update

echo "Install Docker * Docker Compose"

sudo apt-get install docker --yes --force-yes

sudo apt-get install docker-compose --yes --force-yes

apt install python-pip --yes --force-yes

pip install jinja2

apt install python3-pip --yes --force-yes

pip3 install -r requirements

pip install jinja2

python3 getPublicIP.py

python render.py


