#!/bin/bash

# Find all servers startup scripts and run them detached
find /src -name "startup.sh" -print0 | while read -d $'\0' file
do
    chmod +x $file
    # Set working dir to this file location
    location=`dirname $file`
    cd $location
    # Actually run the startup script
    bash $file &
done
