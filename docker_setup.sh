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
