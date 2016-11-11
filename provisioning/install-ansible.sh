#!/usr/bin/env bash

apt-get update
apt-get install -y python-software-properties python-dev python-pip libpq-dev libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev libffi-dev
pip install --upgrade setuptools pip
pip install ansible
