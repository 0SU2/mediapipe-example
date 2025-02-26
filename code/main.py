# STEP 1: Import the necessary modules.
import numpy as np
import mediapipe as mp
from mediapipe.tasks import python
from mediapipe.tasks.python import vision

import cv2
from visualization import visualize

# TO-DO
# Have multiple files and iterate through them
IMAGE_FILE = '../assets/image.jpg'
img = cv2.imread(IMAGE_FILE)
cv2.imshow("test",img)

# STEP 2: Create an FaceDetector object.
base_options = python.BaseOptions(model_asset_path='../detector.tflite')
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
