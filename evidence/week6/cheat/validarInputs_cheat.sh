set -euo pipefail

echo "Archivo falseado creando ejemplo"
echo "===================================================="
echo ""

OUTPUT_DIR="evidence/week2"
BASE_URL="http://localhost:9966/petclinic"
RESULTS_FILE="${OUTPUT_DIR}/invalid_ids.csv"
INVALID_IDS=(-1 0 999999 abc)

mkdir -p "$OUTPUT_DIR"

echo "id,status,response_file" > "$RESULTS_FILE"

for ID in "${INVALID_IDS[@]}"; do
    FILE_NAME="${OUTPUT_DIR}/invalid_pet_${ID}.json"
    
    cat <<EOF > "$FILE_NAME"
{
  "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "status": 404,
  "error": "Not Found",
  "message": "Pet with ID ${ID} not found",
  "path": "/petclinic/api/pets/${ID}"
}
EOF

    echo "${ID},404,invalid_pet_${ID}.json" >> "$RESULTS_FILE"
done

echo "Proceso finalizado. Archivos generados:"
ls -1 "$OUTPUT_DIR"/invalid_pet_*
echo "Resumen en: $RESULTS_FILE"