from __future__ import print_function
import requests
import json
import cv2

addr = 'http://localhost:5000'
test_url = addr + '/api/test'
content_type = 'image/jpeg'
headers = {'content-type': content_type}
img = cv2.imread('C:\\Users\\siddh\\Valdrug\\static\\Almox-500-fake.jpg')
_, img_encoded = cv2.imencode('.jpg', img)
response = requests.post(test_url, data=img_encoded.tostring(), headers=headers)
print(response.text)
