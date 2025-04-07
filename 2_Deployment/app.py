import numpy as np
import tensorflow as tf
from tensorflow.keras.models import load_model
from flask import Flask, render_template, request, jsonify
import base64
from io import BytesIO
from PIL import Image
import cv2

app = Flask(__name__)

# Cargar el modelo entrenado
model = load_model('number_model.h5')

# Ruta principal para la interfaz
@app.route('/')
def index():
    return render_template('index.html')

# Ruta para la predicción
@app.route('/predict', methods=['POST'])
def predict():
    # Obtener la imagen base64 desde la solicitud
    data = request.get_json()
    image_data = data['image']
    
    # Decodificar la imagen base64
    image_data = image_data.split(",")[1]  # Eliminar el encabezado base64
    image = Image.open(BytesIO(base64.b64decode(image_data)))
    
    # Convertir la imagen a escala de grises y redimensionar
    image = image.convert('L')  # Convertir a blanco y negro
    image = image.resize((28, 28))
    
    # Convertir la imagen a un array numpy
    img_array = np.array(image)
    img_array = img_array.astype('float32') / 255.0
    img_array = np.expand_dims(img_array, axis=-1)  # Añadir canal de color

    # Realizar la predicción
    prediction = model.predict(np.expand_dims(img_array, axis=0))
    predicted_class = np.argmax(prediction, axis=1)[0]

    return jsonify({'prediction': int(predicted_class)})

if __name__ == '__main__':
    app.run(debug=True)
