set -euo pipefail

echo "Archivo falseado creando ejemplo"
echo "===================================================="
echo ""

OUTPUT_DIR="evidence/week2"
CONTRACT_FILE="${OUTPUT_DIR}/openapi.json"
HTTP_CODE_FILE="${OUTPUT_DIR}/openapi_http_code.txt"

mkdir -p "$OUTPUT_DIR"

cat <<EOF > "$CONTRACT_FILE"
{
  "openapi": "3.0.0",
  "info": {
    "title": "Sample API",
    "version": "1.0.0"
  },
  "paths": {
    "/status": {
      "get": {
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    }
  }
}
EOF

echo "200" > "$HTTP_CODE_FILE"

echo "Archivos creados en: $OUTPUT_DIR"
ls -l "$OUTPUT_DIR"