#!/bin/bash

# Find all servers startup scripts and run them detached
find /src -name "startup.sh" -print0 | while read -d $'\0' file
do
    chmod +x $file
    # Set working dir to that file location
    location=`dirname $file`
    cd $location
    # Actually run the startup script
    bash $file &
done

# Go through all server files and find our custom nginx configs

# Remove up to last closing bracket }
sed -i 's/\(.*\)}.*$/\1/' /etc/nginx/conf.d/default.conf

find /src -name "config_nginx_location.sh" -print0 | while read -d $'\0' file
do
    chmod +x $file
    NGINX_PATH='UNSET'
    NGINX_HOST='http://localhost:4000'
    bash $file
    # Append the values to nginx conf
    echo '    location '$NGINX_PATH' {' >> /etc/nginx/conf.d/default.conf
    echo '        proxy_pass '$NGINX_HOST';' >> /etc/nginx/conf.d/default.conf
    echo '    }' >> /etc/nginx/conf.d/default.conf
done
# Append the ending bracket
echo '}' >> /etc/nginx/conf.d/default.conf
