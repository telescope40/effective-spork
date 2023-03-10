#!/bin/bash

mkdir prometheus

mkdir pydir

sudo apt-get update

sudo apt-get install docker --yes --force-yes

sudo apt-get install docker-compose --yes --force-yes

apt install python3-pip --yes --force-yes

pip3 install -r requirements

pip install jinja2
#python3 -m venv /pydir/

mv docker-compose.yml monitor/.

python3 getPublicIP.py

python render.py

chmod u+x setup.sh
