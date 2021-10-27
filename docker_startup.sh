#!/bin/bash

echo 'Searching for all server startup files'

# Find all servers startup scripts and run them detached
find /src -name "startup.sh" -print0 | while read -d $'\0' file
do
    chmod +x $file
    # Set working dir to that file location
    location=`dirname $file`
    cd $location
    # Actually run the startup script
    echo 'Executing '$file
    bash $file &
done

echo 'Done executing server startup files'

# Setup nginx config only once
if [ ! -f nginx-config-done ]; then
    touch nginx-config-done;
else
    exit 0;
fi

echo 'Searching for server nginx config files'

# Go through all server files and find our custom nginx configs

# Remove up to last closing bracket }
sed -i 's/\(.*\)}.*$/\1/' /etc/nginx/conf.d/default.conf

find /src -name "config_nginx_location.sh" -print0 | while read -d $'\0' file
do
    chmod +x $file
    NGINX_PATH='UNSET'
    NGINX_HOST='http://localhost:4000'
    echo 'Executing '$file
    source $file
    echo 'Result path '$NGINX_PATH
    echo 'Result url '$NGINX_HOST
    # Append the values to nginx conf
    echo '    location '$NGINX_PATH' {' >> /etc/nginx/conf.d/default.conf
    echo '        proxy_pass '$NGINX_HOST';' >> /etc/nginx/conf.d/default.conf
    echo '    }' >> /etc/nginx/conf.d/default.conf
done
# Append the ending bracket
echo '}' >> /etc/nginx/conf.d/default.conf
