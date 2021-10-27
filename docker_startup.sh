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
