#!/bin/bash
# Script de Inicio de la Aplicación PetClinic REST

echo "Iniciando aplicación PetClinic REST..."

# Verificar si Docker está en ejecución
if ! docker info > /dev/null 2>&1; then
    echo "Docker no está en ejecución. Por favor inicia Docker primero."
    exit 1
fi

# Descargar y ejecutar el contenedor de PetClinic REST
echo "Descargando imagen de PetClinic REST..."
docker pull springcommunity/spring-petclinic-rest

echo "Iniciando contenedor de Pet Clinic REST..."
docker run -d --name spring-petclinic-rest -p 9966:9966 springcommunity/spring-petclinic-rest

# Esperar un momento para que el contenedor inicie
sleep 5

# Verificar si el contenedor está en ejecución
if docker ps | grep -q spring-petclinic-rest; then
    echo "Pet Clinic REST iniciado exitosamente en http://localhost:9966"
    echo "Documentación de la API disponible en: http://localhost:9966/petclinic/swagger-ui.html"
else
    echo "Falló al iniciar Pet Clinic REST"
    exit 1
fi