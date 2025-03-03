# STEP 1: Import the necessary modules.
import os
import numpy as np
import cv2
import mediapipe as mp
from visualization import visualize
from mediapipe.tasks import python
from mediapipe.tasks.python import vision

# TO-DO
# Check for current OS and change the file path
model_path = os.getcwd() + os.sep + 'model' + os.sep + 'detector.tflite'
file_path = os.getcwd() + os.sep + 'images'
IMAGE_ARRAY = os.listdir(file_path)

for IMAGE_FILE in IMAGE_ARRAY:
  CURRENT_IMAGE = cv2.imread(file_path + os.sep + IMAGE_FILE)
  cv2.imshow("test",CURRENT_IMAGE)

  # STEP 2: Create an FaceDetector object.
  base_options = python.BaseOptions(model_asset_path=model_path)
  options = vision.FaceDetectorOptions(base_options=base_options)
  detector = vision.FaceDetector.create_from_options(options)

  # STEP 3: Load the input image.
  image = mp.Image.create_from_file(IMAGE_FILE)

  # STEP 4: Detect faces in the input image.
  detection_result = detector.detect(image)

  # STEP 5: Process the detection result. In this case, visualize it.
  image_copy = np.copy(image.numpy_view())
  annotated_image = visualize(image_copy, detection_result)
  rgb_annotated_image = cv2.cvtColor(annotated_image, cv2.COLOR_BGR2RGB)
  cv2.imshow("test",rgb_annotated_image)
