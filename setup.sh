#!/bin/bash
echo "Create Directory for Prometheus"

mkdir prometheus

echo "Create Directory for Grafana"

mkdir grafana

echo "Copy Datasouce File over to grafana directory"

mv datasource.yml grafana/datasource.yml

echo "apt update ubuntu"

sudo apt-get update

echo "Install Docker * Docker Compose"

sudo apt-get install docker --yes --force-yes

sudo apt-get install docker-compose --yes --force-yes

echo "Installing Depedencies"

apt install python-pip --yes --force-yes

pip install jinja2

apt install python3-pip --yes --force-yes

pip3 install -r requirements

pip install jinja2

echo "Running Startup Script"

python3 getPublicIP.py

python3 render.py


