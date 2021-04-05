from flask import Flask, request, Response
import jsonpickle
import numpy as np
import json
from extract_azure import azure_get_data
from process_drug import process_drug
import cv2
import base64

# Initialize the Flask application
app = Flask(__name__)


# route http posts to this method
@app.route('/process', methods=['POST'])
def test():
    txt = request.form["image"]
    message = txt.replace(" ", "+")
    print(type(message))

    with open("current.jpg", "wb") as fh:
        fh.write(base64.b64decode(message))


    print("Saved image")
    # r = request
    # print(type(r.data))
    filename = 'current.jpg'
    # nparr = np.fromstring(r.data, np.uint8)
    # img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    # cv2.imwrite(filename,img)
    hashset = azure_get_data()
    print(hashset)
    result = process_drug(hashset)
    print(result)
    response = {"Success : 200"}
    response_pickled = jsonpickle.encode(response)
    return result
    # return Response(response=response_pickled, status=200, mimetype="application/json")

app.run(host="0.0.0.0", port=5000)