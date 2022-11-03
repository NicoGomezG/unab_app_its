#!/bin/bash

python manage.py makemigrations
python manage.py migrate --no-input
python manage.py collectstatic --no-input
service apache2 restart
gunicorn proyecto_api.wsgi:application