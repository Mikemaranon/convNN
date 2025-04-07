#!/bin/bash

# Nombre del proyecto
PROJECT_NAME="reconocimiento_codigos_postales"
ROOT_DIR="${PWD}/${PROJECT_NAME}"

# Definir la estructura de directorios
declare -A DIRS=(
    ["1_Business_Case_Discovery"]="Contexto del negocio y antecedentes"
    ["2_Data_Processing"]="Preprocesamiento y exploración de datos"
    ["3_Model_Planning"]="Definición de la arquitectura del modelo"
    ["4_Model_Building"]="Implementación y entrenamiento del modelo"
    ["5_Results_Analysis"]="Evaluación del modelo y análisis de resultados"
    ["6_Deployment"]="Despliegue y puesta en producción"
)

# Subdirectorios específicos
SUBDIRS=(
    "2_Data_Processing/raw_data"
    "2_Data_Processing/processed_data"
    "2_Data_Processing/visualizations"
    "3_Model_Planning/architectures"
    "4_Model_Building/training"
    "4_Model_Building/models"
    "5_Results_Analysis/plots"
    "6_Deployment/api"
    "6_Deployment/models"
)

# Crear los directorios principales
echo "Creando estructura de directorios..."
mkdir -p "$ROOT_DIR"
cd "$ROOT_DIR" || exit

for dir in "${!DIRS[@]}"; do
    mkdir -p "$dir"
    echo "# ${DIRS[$dir]}" > "$dir/README.md"
    echo "Directorio creado: $dir"
done

# Crear subdirectorios específicos
for sub in "${SUBDIRS[@]}"; do
    mkdir -p "$sub"
    touch "$sub/.gitkeep"  # Para mantener vacíos los directorios en Git
    echo "Subdirectorio creado: $sub"
done

# Crear archivos base
echo "Creando archivos base..."
touch "requirements.txt"   # Dependencias del proyecto
touch ".gitignore"         # Ignorar archivos innecesarios
echo "__pycache__/" >> ".gitignore"

# Archivo de inicialización en Python (opcional)
touch "main.py"
echo '"""Punto de entrada del proyecto"""' > "main.py"

echo "Estructura de directorios creada exitosamente en: $ROOT_DIR"
