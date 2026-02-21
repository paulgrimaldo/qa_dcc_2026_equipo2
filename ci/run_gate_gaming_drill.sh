#!/usr/bin/env bash
#
# Gaming Drill del Quality Gate (Semana 6)
# ---------------------------------------
# Demuestra la táctica de "manipulación de evidencia": reemplazo temporal de los
# 4 scripts que alimentan el quality gate por versiones que generan evidencia
# falsa (sin ejecutar el SUT). Luego restaura los scripts originales desde
# ci/backup/.
#
# Objetivo: comparar el comportamiento del gate sin verificación de integridad
# (BEFORE, usando ci/base/run_quality_gate_old.sh) frente al gate actual (AFTER,
# usando ci/run_quality_gate.sh). Cuando exista verificación de integridad de
# artefactos protegidos, el AFTER debería detectar el reemplazo y fallar.
#
# Scripts falseados (reemplazados por sus versiones en evidence/week6/cheat/):
#   - scripts/capturarContratoApi.sh
#   - scripts/capturarVet.sh
#   - scripts/validarInputs.sh
#   - scripts/casos_sistematicos.sh
#
set -euo pipefail

# Ejecutar siempre desde la raíz del repo para que las rutas relativas sean correctas
# (restauración desde ci/backup/ y escritura en scripts/)
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${REPO_ROOT}"

WEEK6_DIR="evidence/week6"
BEFORE_DIR="${WEEK6_DIR}/before"
AFTER_DIR="${WEEK6_DIR}/after"
mkdir -p "${BEFORE_DIR}" "${AFTER_DIR}"

RUNLOG="${WEEK6_DIR}/RUNLOG.md"
SUMMARY="${WEEK6_DIR}/summary.txt"
BACKUP_DIR="ci/backup"
CHEAT_DIR="${WEEK6_DIR}/cheat"
SCRIPTS_DIR="scripts"

# Los 4 scripts del quality gate y sus versiones cheat (formato "script:cheat")
SCRIPT_CHEAT_PAIRS=(
  "capturarContratoApi.sh:capturarContrato_cheat.sh"
  "capturarVet.sh:capturarVet_cheat.sh"
  "validarInputs.sh:validarInputs_cheat.sh"
  "casos_sistematicos.sh:casos_sistematicos_cheat.sh"
)

{
  echo "# RUNLOG - Semana 6 (Gaming Drill)"
  echo ""
  echo "- Fecha: $(date -u +"%Y-%m-%d %H:%M:%S UTC")"
  echo "- Comando: ci/run_gate_gaming_drill.sh"
  echo ""
  echo "## Táctica"
  echo "- Reemplazo temporal de los 4 scripts que alimentan el quality gate"
  echo "  (capturarContratoApi.sh, capturarVet.sh, validarInputs.sh, casos_sistematicos.sh)"
  echo "  por versiones que generan evidencia en evidence/week2 y evidence/week4/week5"
  echo "  sin ejecutar el SUT. Restauración desde ${BACKUP_DIR}/."
  echo ""
} > "${RUNLOG}"

# --- Aplicar cheat: copiar versiones falseadas sobre scripts/ ---
echo "## Aplicando scripts falseados" >> "${RUNLOG}"
for pair in "${SCRIPT_CHEAT_PAIRS[@]}"; do
  script="${pair%%:*}"
  cheat="${pair#*:}"
  if [[ -f "${CHEAT_DIR}/${cheat}" ]]; then
    cp -f "${CHEAT_DIR}/${cheat}" "${SCRIPTS_DIR}/${script}"
    chmod +x "${SCRIPTS_DIR}/${script}"
    echo "- ${SCRIPTS_DIR}/${script} <- ${CHEAT_DIR}/${cheat}" >> "${RUNLOG}"
  else
    echo "⚠️  No existe ${CHEAT_DIR}/${cheat}; se omite ${script}" >> "${RUNLOG}"
  fi
done
echo "" >> "${RUNLOG}"

echo "## BEFORE: gate legacy (sin verificación de integridad)" >> "${RUNLOG}"
echo "- Acción: ejecutar ci/base/run_quality_gate_old.sh con scripts falseados" >> "${RUNLOG}"

set +e
bash ./ci/base/run_quality_gate_old.sh > "${BEFORE_DIR}/gate_output.txt" 2>&1
BEFORE_RC=$?
set -e

# Recoger evidencia generada (BEFORE)
cp -f evidence/week5/SUMMARY.md "${BEFORE_DIR}/SUMMARY.md" 2>/dev/null || true
cp -f evidence/week5/RUNLOG.md "${BEFORE_DIR}/RUNLOG.md" 2>/dev/null || true
cp -f evidence/week4/resumen.txt "${BEFORE_DIR}/systematic_summary.txt" 2>/dev/null || true
cp -f evidence/week4/results.csv "${BEFORE_DIR}/systematic_results.csv" 2>/dev/null || true
cp -f evidence/week2/openapi.json "${BEFORE_DIR}/openapi.json" 2>/dev/null || true
cp -f evidence/week2/vets.json "${BEFORE_DIR}/vets.json" 2>/dev/null || true
cp -f evidence/week2/invalid_ids.csv "${BEFORE_DIR}/invalid_ids.csv" 2>/dev/null || true

echo "- Resultado: rc=${BEFORE_RC}. Evidencia en ${BEFORE_DIR}/" >> "${RUNLOG}"
echo "" >> "${RUNLOG}"

# --- Restaurar los 4 scripts desde ci/backup/ antes de ejecutar AFTER ---
echo "## Restauración de scripts desde ${BACKUP_DIR}/" >> "${RUNLOG}"
for pair in "${SCRIPT_CHEAT_PAIRS[@]}"; do
  script="${pair%%:*}"
  if [[ -f "${BACKUP_DIR}/${script}" ]]; then
    cp -f "${BACKUP_DIR}/${script}" "${SCRIPTS_DIR}/${script}"
    chmod +x "${SCRIPTS_DIR}/${script}"
    echo "- ${SCRIPTS_DIR}/${script} restaurado desde ${BACKUP_DIR}/" >> "${RUNLOG}"
  else
    echo "⚠️  No existe backup ${BACKUP_DIR}/${script}" >> "${RUNLOG}"
  fi
done
# Verificación rápida: ningún script en scripts/ debe contener "falseado" tras restaurar
if grep -l "falseado" "${SCRIPTS_DIR}"/capturarContratoApi.sh "${SCRIPTS_DIR}"/capturarVet.sh "${SCRIPTS_DIR}"/validarInputs.sh "${SCRIPTS_DIR}"/casos_sistematicos.sh 2>/dev/null; then
  echo "⚠️  Restauración incompleta: algún script aún contiene 'falseado'" >> "${RUNLOG}"
else
  echo "- Verificación: scripts restaurados (sin contenido falseado)" >> "${RUNLOG}"
fi
echo "" >> "${RUNLOG}"

echo "## AFTER: gate actual (con scripts originales restaurados)" >> "${RUNLOG}"
echo "- Acción: ejecutar ci/run_quality_gate.sh con scripts restaurados" >> "${RUNLOG}"

set +e
bash ./ci/run_quality_gate.sh > "${AFTER_DIR}/gate_output.txt" 2>&1
AFTER_RC=$?
set -e

# Recoger evidencia (AFTER)
cp -f evidence/week5/SUMMARY.md "${AFTER_DIR}/SUMMARY.md" 2>/dev/null || true
cp -f evidence/week5/RUNLOG.md "${AFTER_DIR}/RUNLOG.md" 2>/dev/null || true

echo "- Resultado: rc=${AFTER_RC}" >> "${RUNLOG}"
echo "" >> "${RUNLOG}"

{
  echo "Semana 6 — Resultado del Gaming Drill"
  echo ""
  echo "BEFORE (gate legacy, sin integridad): rc=${BEFORE_RC}"
  echo "- Esperado: el gate puede completar y la evidencia en evidence/week5 existe"
  echo "  aunque los scripts no hayan ejercitado el SUT (evidencia falseada)."
  echo ""
  echo "AFTER (gate actual, con scripts originales restaurados): rc=${AFTER_RC}"
  echo "- Ejecutado tras restaurar los 4 scripts desde ci/backup/; evidencia real del SUT."
  echo ""
  echo "Evidencia:"
  echo "- ${BEFORE_DIR}/gate_output.txt"
  echo "- ${BEFORE_DIR}/systematic_summary.txt, systematic_results.csv, etc."
  echo "- ${AFTER_DIR}/gate_output.txt"
} > "${SUMMARY}"

echo "✅ Gaming drill completado. Ver evidencia en ${WEEK6_DIR}/"
exit 0
