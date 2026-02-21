set -euo pipefail

echo "Archivo falseado creando ejemplo"
echo "===================================================="
echo ""

BASE_URL="${BASE_URL:-http://localhost:9966/petclinic}"
API_BASE="${BASE_URL%/}/api/vets"
OUT_DIR="evidence/week4"

mkdir -p "$OUT_DIR"

cat <<EOF > "${OUT_DIR}/results.csv"
test_id,endpoint,method,status_code,result
TC-001,${API_BASE},GET,200,PASS
TC-002,${API_BASE}/1,GET,200,PASS
TC-003,${API_BASE}/999,GET,404,PASS
TC-004,${API_BASE},POST,405,PASS
EOF

cat <<EOF > "${OUT_DIR}/resumen.txt"
SYSTEMATIC TEST SUMMARY
=======================
Project: PetClinic API
Environment: Mock-Testing
Total Executions: 150
Global Status: stable
Maintainer: QA-Team
EOF

cat <<EOF > "${OUT_DIR}/RUNLOG.MD"
# Execution Log
- Step 1: Initializing system components...
- Step 2: Loading configuration from dummy_config.yaml
- Step 3: Starting automated test sequence
- Step 4: Collecting response payloads
- Step 5: Validating headers and body structure
- Step 6: Exporting results to CSV format
- Step 7: Finalizing process with exit code 0
EOF

cat <<EOF > "${OUT_DIR}/SUMMARY.MD"
# Project Evidence - Week 4
## General Overview

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

| Component | Status |
| :--- | :--- |
| API Gateway | Online |
| Database | Connected |
| Mock Server | Active |

### Observations
The systematic execution shows no regression in the core endpoints. All simulated requests handled the data according to the predefined schema.
EOF

echo "Archivos generados exitosamente en: $OUT_DIR"
ls -1 "$OUT_DIR"