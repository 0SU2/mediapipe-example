#!/bin/bash

make -v &>/dev/null
if [ $? -ne 0 ]; then
   echo "Something!"
   exit 1
fi
echo "Okay!"  
