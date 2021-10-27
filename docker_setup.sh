#!/bin/bash

echo 'Running Docker server setup files'

# Find all servers setup scripts and run them 1 by 1
find /src -name "setup.sh" -print0 | while read -d $'\0' file
do
    chmod +x $file
    # Set working dir to that file location
    location=`dirname $file`
    cd $location
    # Actually run the setup script
    echo 'Executing '$file
    bash $file
done

echo 'Done with Docker server setup files'

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
# Append the removed ending bracket
echo '}' >> /etc/nginx/conf.d/default.conf
