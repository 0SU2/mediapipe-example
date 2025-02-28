#!/bin/bash

echo "Starting script..."
echo "--This script will install for you python 3.11 <= in this directory. This to prevent the using of the python version you already have in your system."
sleep 3

# Instaling python in the current directory with an specific name"
curl -o "python-3.11.2.tgz" https://www.python.org/ftp/python/3.11.2/Python-3.11.2.tgz
if [ $? -eq 1 ]; then
    echo "Error, aborting!"
    exit 1
fi

# TO-DO
# We could check if the user already have this custom build install
echo "--Preparing python python 3.11"
mkdir python-3.11.2
tar zxvf python-3.11.2.tgz -C python-3.11.2 &>/dev/null
if [ $? -eq 1 ]; then
    echo "Error, aborting!"
    exit 1
fi

mkdir python-3.11.2/Python-3.11.2/custom-build
cd python-3.11.2/Python-3.11.2/custom-build
sleep 3

../configure --with-pydebug
# Check if make exist
make -v &>/dev/null
if [ $? -eq 1 ]; then
    echo "Please install make to continue"
    exit 1
fi

echo "---Building python, this could take sometime..."
make &>/dev/null
if [ $? -eq 1 ]; then
    # TO-DO
    # Have a log file to repond if something happen
    echo "Something happend with make, check logs"
    exit 1
fi

sleep 3
# Now python its installed, do the pip install also
echo "---Installing pip in the virtual enviroment..."
curl -O https://bootstrap.pypa.io/get-pip.py &>/dev/null
./custom-build/python get-pip.py

# Check if pip was install succefully
if [ $? -eq 1 ]; then
    
