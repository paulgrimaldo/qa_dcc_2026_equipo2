#!/usr/bin/env bash
# Script de Captura de Veterinarios y servicios para Pet Clinic REST
# 
# Escenario Q4: Respuesta "bien formada" en listado de veterinarios y servicios (Data Shape Sanity)
# 
# Este script atiende al escenario Q4 capturando el listado de veterinarios y servicios
# y validando que sea una respuesta JSON bien formada.
#
# Estímulo: se solicita GET /vets
# Entorno: ejecución local, sin carga, 1 vez
# Respuesta: el cuerpo es JSON (no HTML / texto inesperado)
# Medida (falsable): el cuerpo comienza con '[' y el request devuelve HTTP 200
# Evidencia: evidence/week2/vets.json y evidence/week2/vets_http_code.txt
#
# Los resultados se guardan en evidence/week2/

set -euo pipefail

echo "📦 Escenario Q4: Respuesta Bien Formada en Veterinarios y Servicios"
echo "====================================================="
echo ""

# Configuración
OUTPUT_DIR="evidence/week2"
BASE_URL="http://localhost:9966/petclinic"
VETS_FILE="${OUTPUT_DIR}/vets.json"
HTTP_CODE_FILE="${OUTPUT_DIR}/vets_http_code.txt"

echo "Configuración:"
echo "  - URL Base: ${BASE_URL}"
echo "  - Endpoint: /api/vets"
echo "  - Directorio de salida: ${OUTPUT_DIR}"
echo ""

# Crear directorio de evidencias si no existe
mkdir -p "${OUTPUT_DIR}"

# ===== Captura de Veterinarios y Servicios =====
echo "🔄 Capturando veterinarios y servicios..."

code=$(curl -s -o "${VETS_FILE}" -w "%{http_code}" "${BASE_URL}/api/vets")
echo "${code}" > "${HTTP_CODE_FILE}"

# ===== Validación de Formato JSON =====
echo "🔎 Validando formato JSON..."

# Verificar que el archivo comienza con '['
first_char=$(head -c 1 "${VETS_FILE}")

if [ "${first_char}" != "[" ]; then
    echo "   ❌ ERROR: El archivo no comienza con '['  (primer carácter: '${first_char}')"
    exit 1
fi

echo "   ✓ Archivo comienza con '[' (JSON válido)"

echo ""
echo "================================"
echo "📊 Resultados de Validación"
echo "================================"
echo "Código HTTP: ${code}"
echo "Formato JSON: Válido (comienza con '[')"
echo "Validación oráculo: HTTP ${code} + JSON bien formado"

if [ "${code}" = "200" ]; then
    echo ""
    echo "✅ ÉXITO: Los veterinarios y servicios son accesibles y bien formados"
    echo ""
    echo "📁 Archivos generados:"
    echo "   - ${VETS_FILE}"
    echo "   - ${HTTP_CODE_FILE}"
else
    echo ""
    echo "❌ FALLO: Se esperaba HTTP 200, se recibió HTTP ${code}"
    exit 1
fi