#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="evidence/week5"
mkdir -p "${OUT_DIR}"

RUNLOG="${OUT_DIR}/RUNLOG.md"
{
  echo "# RUNLOG - Semana 5"
  echo ""
  echo "- Fecha: $(date -u +"%Y-%m-%d %H:%M:%S UTC")"
  echo "- Comando: ci/run_quality_gate.sh"
  echo ""
  echo "## Pasos ejecutados"
} > "${RUNLOG}"

echo "- Iniciar Pet Clinic REST" >> "${RUNLOG}"
./setup/run_sut.sh

echo "- Healthcheck" >> "${RUNLOG}"
./setup/healthcheck_sut.sh

echo "- Capturar Contrato de las APIS" >> "${RUNLOG}"
./scripts/capturarContratoApi.sh

echo "- Capturar Listado de Veterinarios y Servicios" >> "${RUNLOG}"
./scripts/capturarVet.sh

echo "- Verificar Robustez ante Entradas Inválidas" >> "${RUNLOG}"
./scripts/validarInputs.sh

echo "- Ejecutar casos Sistemáticos para verificar oráculos" >> "${RUNLOG}"
./scripts/casos_sistematicos.sh

cp -f evidence/week2/openapi.json "${OUT_DIR}/openapi.json"
cp -f evidence/week2/openapi_http_code.txt "${OUT_DIR}/openapi_http_code.txt"
cp -f evidence/week2/vets.json "${OUT_DIR}/vets.json"
cp -f evidence/week2/vets_http_code.txt "${OUT_DIR}/vets_http_code.txt"
cp -f evidence/week2/invalid_ids.csv "${OUT_DIR}/invalid_ids.csv"
cp -f evidence/week2/invalid_pet_*.json "${OUT_DIR}/" 2>/dev/null || true

cp -f evidence/week4/results.csv "${OUT_DIR}/systematic_results.csv"
cp -f evidence/week4/resumen.txt "${OUT_DIR}/systematic_summary.txt"

SUMMARY="${OUT_DIR}/SUMMARY.md"
{
  echo "# Resumen - Semana 5 (Quality Gate)"
  echo ""
  echo "## Evidencia generada"
  echo "- Contrato: ${OUT_DIR}/openapi.json"
  echo "- Inventario: ${OUT_DIR}/vets.json"
  echo "- Entradas inválidas: ${OUT_DIR}/invalid_ids.csv"
  echo "- Casos sistemáticos: ${OUT_DIR}/systematic_results.csv"
  echo ""
} > "${SUMMARY}"

echo "" >> "${RUNLOG}"
echo "## Evidencia producida" >> "${RUNLOG}"
echo "- ${SUMMARY}" >> "${RUNLOG}"
echo "- ${OUT_DIR}/openapi.json" >> "${RUNLOG}"
echo "- ${OUT_DIR}/vets.json" >> "${RUNLOG}"
echo "- ${OUT_DIR}/invalid_ids.csv" >> "${RUNLOG}"
echo "- ${OUT_DIR}/systematic_results.csv" >> "${RUNLOG}"

echo "✅ Quality gate completado. Evidencia en ${OUT_DIR}/"