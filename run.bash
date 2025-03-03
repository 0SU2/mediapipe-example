#!/bin/bash

echo "Starting script..."
echo "--This script will install for you python 3.11 <= in this directory. This to prevent the using of the python version you already have in your system."
sleep 3

# Installing python in the current directory with an specific name"
curl -o "python-3.11.2.tgz" https://www.python.org/ftp/python/3.11.2/Python-3.11.2.tgz
if [ $? -eq 1 ]; then
    echo "Error, aborting!"
    exit 1
fi

# Installing the model
curl --create-dirs --output ./model/detector.tflite https://storage.googleapis.com/mediapipe-models/face_detector/blaze_face_short_range/float16/1/blaze_face_short_range.tflite

# TO-DO
# We could check if the user already have this custom build install
echo "--Preparing python python 3.11"
mkdir python-3.11.2
tar zxvf python-3.11.2.tgz -C python-3.11.2
if [ $? -eq 1 ]; then
    echo "Error, aborting!"
    exit 1
fi
rm python-3.11.2.tgz

mkdir python-3.11.2/Python-3.11.2/custom-build
cd python-3.11.2/Python-3.11.2/custom-build
sleep 3

../configure --with-pydebug
# Check if make exist
make -v
if [ $? -eq 1 ]; then
    echo "Please install make to continue"
    exit 1
fi

echo "---Building python, this could take sometime..."
make
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
./python get-pip.py

# Check if pip was install succefully
if [ $? -eq 1 ]; then
    echo "Fatal error"
    exit 1
fi

# Now create the virtual enviroment to finish everything and make the test with the image
./python -m pip install virtualenv
if [ $? -eq 1 ]; then
    echo "Error, virtualenv could not be installed in your folder."
    exit 1
fi

./python -m virtualenv python-3.11-virtual-enviroment
if [ $? -eq 1 ]; then
    echo "Error while creating your virtual enviroment."
    exit 1
fi

# Now, initialize the virtual enviroment
echo "--Right now the script will initialized the virtual enviroment, your console will change, but you can exit with the command deactivate. So, do not worried :)"
sleep 4

source python-3.11-virtual-enviroment/bin/activate

# Download opencv and mediapipe
pip install opencv-python mediapipe

# Run the program and we are done
cd ../../../
python ./code/main.py
echo "--Running program..."
