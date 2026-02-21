#!/usr/bin/env bash
set -euo pipefail

# Post-gate: verificación semántica del contenido de la evidencia (week5).
# Se ejecuta después del gate. La verificación de integridad SHA está en verify_gate_integrity.sh (pre-gate).

EVIDENCE_DIR="evidence/week5"
EVIDENCE_JSON_FILES=(
  "invalid_pet_-1.json"
  "invalid_pet_0.json"
  "invalid_pet_999999.json"
  "invalid_pet_abc.json"
)
# Edad máxima del timestamp en la evidencia (segundos). Por defecto 24h.
MAX_AGE_SECONDS="${MAX_AGE_SECONDS:-86400}"

echo "== Post-gate: Verificación de contenido (evidencia) =="
echo "Directorio: ${EVIDENCE_DIR}"
echo "Archivos: ${EVIDENCE_JSON_FILES[*]}"
echo ""

FAIL=0

for name in "${EVIDENCE_JSON_FILES[@]}"; do
  f="${EVIDENCE_DIR}/${name}"
  if [[ ! -f "${f}" ]]; then
    echo "❌ Falta archivo de evidencia: ${f}"
    FAIL=1
    continue
  fi

  # Status debe ser 500 (peticiones inválidas)
  status=$(jq -r '.status // empty' "${f}")
  if [[ "${status}" != "500" ]]; then
    echo "❌ ${f}: status esperado 500, obtenido: ${status:-vacío}"
    FAIL=1
    continue
  fi

  # Timestamp debe existir y ser reciente respecto a esta ejecución
  ts=$(jq -r '.timestamp // empty' "${f}")
  if [[ -z "${ts}" ]]; then
    echo "❌ ${f}: falta campo timestamp"
    FAIL=1
    continue
  fi

  now_epoch=$(date +%s)
  if date --version 2>/dev/null | head -1 | grep -q GNU; then
    json_epoch=$(date -d "${ts}" +%s 2>/dev/null) || json_epoch=0
  else
    ts_short=$(echo "${ts}" | sed 's/\.[0-9]*Z$/Z/')
    json_epoch=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "${ts_short}" +%s 2>/dev/null) || json_epoch=0
  fi

  if [[ "${json_epoch}" -eq 0 ]]; then
    echo "❌ ${f}: timestamp no parseable: ${ts}"
    FAIL=1
    continue
  fi

  diff=$((now_epoch - json_epoch))
  if [[ ${diff} -lt 0 ]]; then
    echo "✅ OK (contenido): ${f} (status=500, timestamp presente)"
    continue
  fi
  if [[ ${diff} -gt "${MAX_AGE_SECONDS}" ]]; then
    echo "❌ ${f}: timestamp demasiado antiguo (${diff}s > ${MAX_AGE_SECONDS}s). Ejecute el gate y vuelva a verificar."
    echo "   timestamp: ${ts}"
    FAIL=1
    continue
  fi

  echo "✅ OK (contenido): ${f} (status=500, timestamp reciente)"
done

if [[ "${FAIL}" -ne 0 ]]; then
  echo ""
  echo "➡️  Post-gate falló: la evidencia no cumple (archivos faltantes, status distinto de 500 o timestamp fuera de ventana)."
  echo "   Ejecute el script del gate que genera la evidencia y vuelva a ejecutar esta verificación."
  exit 2
fi

echo ""
echo "✅ Verificación de contenido superada (post-gate)."
