Write-Output "This script need a lower version of python 3.12<= to work..."
Start-Sleep -Seconds 3
Write-Output "Please install python inside this folder with the name 'python-3.11', in the setup it will ask you if you want to make a CUSTOM INSTALLATION, you select that option, click NEXT, and install inside of this folder with the previous name 'python-3.11'."
Write-Output "You need to use this link -> https://www.python.org/ftp/python/3.11.1/python-3.11.1-amd64.exe,"
Write-Output "copy and pasted, or shift + right click to open in your browser, and follow the previous steps, then return to this script and continue."
# Wait to user to install a python version inside the folder
PAUSE

$currenDirectoryInstall = Get-Location
# check if python was previously install
if (-not(Test-Path -path $currenDirectoryInstall'\python-3.11')) {
    Write-Error "Please install python 3.11 and saved with the previous name provided."
    exit
} else {
    Write-Output "Continuing..."
}

# Write-Output "Making the first test with python"
try {
    .\python-3.11\python.exe --version
} catch {
    Write-Error "Something happend!"
} finally {
    Write-Output "Finish Testing"
}

Write-Output "Creating virtual enviroment for python"
try {
    .\python-3.11\python.exe -m pip install virtualenv
} catch {
    Write-Error "Check if your system have installed pip"
    exit
} finally {
    Write-Output "Continuing..."
}

Write-Output "Creating your virtual enviroment."
.\python-3.11\python.exe -m virtualenv .\python-virtual-enviroment

Write-Output "Activating virtual enviroment for pip"
try {
    .\python-virtual-enviroment\Scripts\activate
} catch {
    Write-Error "Something happen in you virtual enviroment, checked plis"
    exit
} finally {
    Write-Output "Continuing..."
}

Write-Output "Installing mediapipe and opencv in your virtual enviroment."
pip install mediapipe opencv-python

Write-Output "Testing"
python ./code/main.py