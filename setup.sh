#!/bin/bash
mkdir monitor && cd monitor

mkdir prometheus

sudo apt-get update

sudo apt-get install docker --yes --force-yes

sudo apt-get install docker-compose --yes --force-yes

apt install python3-pip --yes --force-yes

pip3 install -r requirements

python3 -m venv /pydir/

mv docker-compose.yml monitor/.

python3 getPublicIP.py

python render.py
