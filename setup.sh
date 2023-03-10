#!/bin/bash
mkdir monitor && cd monitor

mkdir prometheus

sudo apt-get update

sudo apt-get install docker

sudo apt-get install docker-compose

git clone git@github.com:telescope40/effective-spork.git
