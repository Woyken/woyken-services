#!/bin/bash

sed -i "s|NGINX_PORT|"$PORT"|g" /src/nginx.conf.template

echo replaced nginx port with $PORT

node /src/server.js
