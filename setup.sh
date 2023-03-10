#!/bin/bash
mkdir monitor && cd monitor

mkdir prometheus

sudo apt-get update

sudo apt-get install docker --yes --force-yes

sudo apt-get install docker-compose --yes --force-yes

