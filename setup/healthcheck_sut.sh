#!/bin/bash
# Script de Verificación de Salud para la Aplicación Pet Clinic REST

echo "Realizando verificación de salud en la aplicación Pet Clinic REST..."

# Verificar si el contenedor de Docker está en ejecución
if ! docker ps | grep -q spring-petclinic-rest; then
    echo "❌ El contenedor de Pet Clinic REST no está en ejecución"
    exit 1
fi

# Verificar si la aplicación está respondiendo
echo "Verificando salud de la aplicación..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:9966/petclinic/actuator/health)
    
if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "✅ Pet Clinic REST está saludable y respondiendo"
    echo "📊 Estado de la aplicación: En ejecución"
    echo "🌐 Endpoint: http://localhost:9966"
    
    # Verificaciones adicionales
    echo "🔍 Estado del contenedor:"
    docker stats --no-stream spring-petclinic-rest | tail -n 1
    
    exit 0
else
    echo "❌ Pet Clinic REST no está respondiendo (HTTP $HTTP_STATUS)"
    echo "🔧 Verificando logs del contenedor..."
    docker logs spring-petclinic-rest --tail 10
    exit 1
fi