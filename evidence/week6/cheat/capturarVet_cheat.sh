set -euo pipefail

echo "Archivo falseado creando ejemplo"
echo "===================================================="
echo ""

OUTPUT_DIR="evidence/week2"
VETS_FILE="${OUTPUT_DIR}/vets.json"
HTTP_CODE_FILE="${OUTPUT_DIR}/vets_http_code.txt"

mkdir -p "$OUTPUT_DIR"

cat <<EOF > "$VETS_FILE"
[
  {
    "id": 1,
    "firstName": "James",
    "lastName": "Carter",
    "specialties": []
  },
  {
    "id": 2,
    "firstName": "Helen",
    "lastName": "Leary",
    "specialties": ["radiology"]
  },
  {
    "id": 3,
    "firstName": "Linda",
    "lastName": "Douglas",
    "specialties": ["dentistry", "surgery"]
  }
]
EOF

echo "200" > "$HTTP_CODE_FILE"

echo "Archivos de veterinarios creados exitosamente en: $OUTPUT_DIR"
ls -1 "$OUTPUT_DIR"