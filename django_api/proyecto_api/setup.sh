#!/bin/bash

pip install -r requirements.txt
apt-get update
apt-get install default-libmysqlclient-dev
apt-get -y install apache2
a2enmod wsgi
a2enmod proxy
a2enmod proxy_http
a2enmod ssl
rm /etc/apache2/sites-enabled/*
cp servicio.conf /etc/apache2/sites-enabled