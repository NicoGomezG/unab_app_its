#!/bin/bash
docker build --no-cache -t contenedor .
docker run -d -p 80:80 contenedor