import tensorflow as tf
from tensorflow.keras.preprocessing import image
import numpy as np

# Cargar el modelo (asegúrate de colocar el archivo en el directorio adecuado)
model = tf.keras.models.load_model('number_model.h5')

def preprocess_image(img_path):
    img = image.load_img(img_path, target_size=(224, 224))  # Ajusta el tamaño según sea necesario
    img_array = image.img_to_array(img)
    img_array = np.expand_dims(img_array, axis=0)
    img_array /= 255.0  # Normalizar si tu modelo fue entrenado de esta forma
    return img_array

def predict(img_path):
    img = preprocess_image(img_path)
    predictions = model.predict(img)
    return predictions
