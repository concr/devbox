#!/usr/bin/env bash

apt-get install -y python-software-properties
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get install -y ansible build-essential vim-nox
apt-get autoremove
apt-get autoclean
