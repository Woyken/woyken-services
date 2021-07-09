#!/bin/bash

#sed -i "s|NGINX_PORT|"$PORT"|g" /src/nginx.conf.template

#echo replaced nginx port with $PORT

#cp /src/nginx.conf.template /etc/nginx/nginx.conf

# Detached run of server
node /src/server.js &

exec nginx -g 'daemon off;'
