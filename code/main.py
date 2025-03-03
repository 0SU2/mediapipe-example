# STEP 1: Import the necessary modules.
import os
import cv2
from mediapipe import solutions

# Prepare pre-created solutions made from mediapipe
mp_face_mesh = solutions.face_mesh
mp_drawing = solutions.drawing_utils
mp_drawing_styles = solutions.drawing_styles

# Check for current OS and change the file path
file_path = os.getcwd() + os.sep + 'images'
IMAGE_ARRAY = os.listdir(file_path)

for IMAGE_FILE in IMAGE_ARRAY:
  FULL_PATH_IMAGE = file_path + os.sep + IMAGE_FILE
  CURRENT_IMAGE = cv2.resize(cv2.imread(FULL_PATH_IMAGE), (600,600))

  # Applaying face mesh model using mediapipe
  CURRENT_IMAGE = cv2.cvtColor(CURRENT_IMAGE, cv2.COLOR_BGR2RGB)
  results = mp_face_mesh.FaceMesh(max_num_faces=2, refine_landmarks=True).process(CURRENT_IMAGE)
  
  # Draw annotations on the image
  CURRENT_IMAGE = cv2.cvtColor(CURRENT_IMAGE, cv2.COLOR_RGB2BGR)
  if results.multi_face_landmarks:
    # Loop through all landmarks
    for face_landmarks in results.multi_face_landmarks:
      # Draw Iris
      mp_drawing.draw_landmarks(
        image=CURRENT_IMAGE, 
        landmark_list=face_landmarks, 
        connections=mp_face_mesh.FACEMESH_TESSELATION,
        landmark_drawing_spec=None,
        connection_drawing_spec=mp_drawing_styles.get_default_face_mesh_tesselation_style()
      )
      mp_drawing.draw_landmarks(
        image=CURRENT_IMAGE, 
        landmark_list=face_landmarks, 
        connections=mp_face_mesh.FACEMESH_IRISES,
        landmark_drawing_spec=None,
        connection_drawing_spec=mp_drawing_styles.get_default_face_mesh_iris_connections_style()
      )
      mp_drawing.draw_landmarks(
        image=CURRENT_IMAGE, 
        landmark_list=face_landmarks, 
        connections=mp_face_mesh.FACEMESH_CONTOURS,
        landmark_drawing_spec=None,
        connection_drawing_spec=mp_drawing_styles.get_default_face_mesh_contours_style()
      )

  cv2.imshow("Result", CURRENT_IMAGE)
  cv2.waitKey(0)

cv2.destroyAllWindows()