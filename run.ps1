$currenDirectoryInstall = Get-Location
# check if python was previously install
if (-not(Test-Path -path $currenDirectoryInstall'\python-custom-3.9')) {
    Write-Output "Downloading necesary files"
    curl -o 'python-3.9.12-embed-amd64.zip' 'https://www.python.org/ftp/python/3.9.12/python-3.9.12-embed-amd64.zip'
    curl -o 'detector.tflite' 'https://storage.googleapis.com/mediapipe-models/face_detector/blaze_face_short_range/float16/1/blaze_face_short_range.tflite'
    Write-Output "Unzip file recived from python"
    Expand-Archive -LiteralPath $currenDirectoryInstall'\python-3.9.12-embed-amd64.zip' -DestinationPath $currenDirectoryInstall'\python-custom-3.9'
    curl -o '.\python-custom-3.9\get-pip.py' 'https://bootstrap.pypa.io/get-pip.py'
} else {
    Write-Output "python was instaled previously! Skipping steps..."
}

Write-Output "Making the first test with python"
try {
    .\python-custom-3.9\python.exe --version
} catch {
    Write-Error "Something happend!"
} finally {
    Write-Output "Finish Testing"
}

Write-Output "Creating virtual enviroment for python"
.\python-custom-3.9\python.exe .\python-custom-3.9\get-pip.py
.\python-custom-3.9\python.exe -m venv $currenDirectoryInstall'\python-3.9-virtual-venv'

Write-Output "Activating virtual enviroment for pip"
.\python-3.9-virtual-venv\Scripts\Activate.ps1

Write-Output "Installing mediapipe and opencv"
.\python-3.9-virtual-venv\Scripts\pip install mediapipe opencv

#Write-Output "Testing"
#.\python-custom-3.9\python.exe run ./code/main.py