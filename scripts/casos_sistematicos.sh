#!/usr/bin/env bash
set -euo pipefail

# Semana 4 — Ejecución sistemática de casos
# Endpoint objetivo: GET /api/vets/{id}

BASE_URL="${BASE_URL:-http://localhost:9966/petclinic}"
API_BASE="${BASE_URL%/}/api/vets"
OUT_DIR="evidence/week4"

ID_EXISTENTE="${ID_EXISTENTE:-1}"
ID_INEXISTENTE="${ID_INEXISTENTE:-999999999999}"

mkdir -p "${OUT_DIR}"

RESULTS="${OUT_DIR}/results.csv"
echo "tc_id,input_id,partition,http_code,oracle_pass,notes,response_file" > "${RESULTS}"

# ---------- helpers ----------

urlencode() {
  jq -nr --arg v "$1" '$v|@uri'
}

first_non_ws_char() {
  local file="$1"
  awk '
    {
      for (i = 1; i <= length($0); i++) {
        c = substr($0, i, 1)
        if (c !~ /[[:space:]]/) { print c; exit }
      }
    }
  ' "$file"
}

is_json_valid() {
  jq . "$1" >/dev/null 2>&1
}

# ---------- core runner ----------

run_case() {
  local tc_id="$1"
  local input_id="$2"
  local partition="$3"
  local repetitions="${4:-1}"

  local encoded_id
  encoded_id=$(urlencode "${input_id}")

  local url="${API_BASE}/${encoded_id}"
  local resp_file="${OUT_DIR}/${tc_id}_response.json"

  local http_code=""
  local notes=""
  local pass="true"
  local last_body=""

  for ((i=1;i<=repetitions;i++)); do
    rm -f "${resp_file}"

    http_code=$(curl -s -o "${resp_file}" -w "%{http_code}" "${url}" || true)

    # Blindaje: si no hay archivo de respuesta
    if [[ ! -f "${resp_file}" ]]; then
      pass="false"
      notes+="NO_RESPONSE_FILE;"
      break
    fi

    # OR2 — no HTML
    local c
    c=$(first_non_ws_char "${resp_file}")
    if [[ "${c}" == "<" ]]; then
      pass="false"
      notes+="OR2_fail_html;"
      mv "${resp_file}" "${OUT_DIR}/${tc_id}_response.txt"
      resp_file="${OUT_DIR}/${tc_id}_response.txt"
      break
    fi

    # OR3 — no 5xx
    if [[ "${http_code}" =~ ^5 ]]; then
      pass="false"
      notes+="OR3_fail_5xx;"
      break
    fi

    # OR4 — JSON válido si no es 500
    if [[ "${http_code}" != "500" ]]; then
      if ! is_json_valid "${resp_file}"; then
        pass="false"
        notes+="OR4_fail_invalid_json;"
        break
      fi
    fi

    # OR5 — IDs inválidos no aceptados
    if [[ "${partition}" == "P1" || "${partition}" == "P2" ]]; then
      if [[ "${http_code}" == "200" ]]; then
        pass="false"
        notes+="OR5_fail_invalid_id_200;"
        break
      fi
    fi

    # OR6–OR8 — IDs válidos
    if [[ "${partition}" == "P3" ]]; then
      if [[ "${http_code}" != "200" && "${http_code}" != "404" ]]; then
        pass="false"
        notes+="OR6_fail_unexpected_code;"
        break
      fi

      if [[ "${http_code}" == "200" ]]; then
        # OR7 — body no vacío
        if grep -q '^{[[:space:]]*}$' "${resp_file}"; then
          notes+="OR7_strict_empty_body;"
        fi

        # OR8 — id presente
        if ! grep -q '"id"' "${resp_file}"; then
          notes+="OR8_strict_missing_id;"
        fi
      fi
    fi

    # OR9 — idempotencia
    if [[ "${i}" -gt 1 ]]; then
      if [[ "${last_body}" != "$(cat "${resp_file}")" ]]; then
        notes+="OR9_strict_non_idempotent;"
      fi
    fi
    last_body="$(cat "${resp_file}")"
  done

  echo "${tc_id},${input_id},${partition},${http_code},${pass},${notes},${resp_file}" >> "${RESULTS}"
}

# ---------- ejecución de casos ----------

run_case "test_case_01" "abc" "P1"
run_case "test_case_02" "1.5" "P1"
run_case "test_case_03" "-1" "P2"
run_case "test_case_04" "0" "P2"
run_case "test_case_05" "1" "P3"
run_case "test_case_06" "2" "P3"
run_case "test_case_07" "999999" "P3"
run_case "test_case_08" "2147483647" "P3"
run_case "test_case_09" "0001" "P3"
run_case "test_case_10" "01" "P3"
run_case "test_case_11" "-2147483648" "P2"
run_case "test_case_12" "999999999" "P3"
run_case "test_case_13" " 1 " "P1"
run_case "test_case_14" "+1" "P3"
run_case "test_case_15" "9223372036852" "P1"
run_case "test_case_16" "%31" "P1"
run_case "test_case_17" "${ID_EXISTENTE}" "P3"
run_case "test_case_18" "${ID_INEXISTENTE}" "P3"
run_case "test_case_19" "${ID_EXISTENTE}" "P3" 5

# ---------- resumen ----------

total=$(tail -n +2 "${RESULTS}" | wc -l | tr -d ' ')
passed=$(tail -n +2 "${RESULTS}" | awk -F',' '$5=="true"{c++} END{print c+0}')
failed=$(( total - passed ))

cat > "${OUT_DIR}/resumen.txt" <<EOF
Semana 4 — Resumen
- Total casos: ${total}
- Pass (oráculo mínimo): ${passed}
- Fail (oráculo mínimo): ${failed}

Notas:
- OR7–OR9 se reportan como estrictas (no bloqueantes)
- test_case_19 ejecuta 5 veces el mismo input para idempotencia
EOF

echo "[OK] Semana 4: 19 test cases ejecutados. Evidencia en ${OUT_DIR}"
