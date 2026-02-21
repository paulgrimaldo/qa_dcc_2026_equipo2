# RUNLOG - Semana 6 (Gaming Drill)

- Fecha: 2026-02-21 04:15:10 UTC
- Comando: ci/run_gate_gaming_drill.sh

## Táctica
- Reemplazo temporal de los 4 scripts que alimentan el quality gate
  (capturarContratoApi.sh, capturarVet.sh, validarInputs.sh, casos_sistematicos.sh)
  por versiones que generan evidencia en evidence/week2 y evidence/week4/week5
  sin ejecutar el SUT. Restauración desde ci/backup/.

## Aplicando scripts falseados
- scripts/capturarContratoApi.sh <- evidence/week6/cheat/capturarContrato_cheat.sh
- scripts/capturarVet.sh <- evidence/week6/cheat/capturarVet_cheat.sh
- scripts/validarInputs.sh <- evidence/week6/cheat/validarInputs_cheat.sh
- scripts/casos_sistematicos.sh <- evidence/week6/cheat/casos_sistematicos_cheat.sh

## BEFORE: gate legacy (sin verificación de integridad)
- Acción: ejecutar ci/base/run_quality_gate_old.sh con scripts falseados
- Resultado: rc=0. Evidencia en evidence/week6/before/

## Restauración de scripts desde ci/backup/
- scripts/capturarContratoApi.sh restaurado desde ci/backup/
- scripts/capturarVet.sh restaurado desde ci/backup/
- scripts/validarInputs.sh restaurado desde ci/backup/
- scripts/casos_sistematicos.sh restaurado desde ci/backup/
- Verificación: scripts restaurados (sin contenido falseado)

## AFTER: gate actual (con scripts originales restaurados)
- Acción: ejecutar ci/run_quality_gate.sh con scripts restaurados
- Resultado: rc=0

