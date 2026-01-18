#!/bin/bash
# Script de Detención de la Aplicación Pet Clinic REST

echo "Deteniendo aplicación Pet Clinic REST..."

# Detener y eliminar el contenedor de Pet Clinic REST
if docker ps | grep -q spring-petclinic-rest; then
    echo "Deteniendo contenedor de Pet Clinic REST..."
    docker stop spring-petclinic-rest
    echo "Eliminando contenedor de Pet Clinic REST..."
    docker rm spring-petclinic-rest
    echo "Pet Clinic REST detenido exitosamente"
else
    echo "El contenedor de Pet Clinic REST no está en ejecución"
fi