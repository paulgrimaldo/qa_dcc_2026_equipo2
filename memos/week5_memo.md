# Memo de Progreso — Semana 5
**Fecha:** 12/02/2026  
**Equipo:** Equipo 2  
**Semana:** 5 de 8

## Objetivos de la semana
- Definir un **quality gate** alineado con los riesgos priorizados (Semana 3) y con oráculos/casos sistemáticos (Semana 4).
- Convertir el gate en una **ejecución reproducible** en entorno local y en CI mediante un script único.
- Generar y publicar **evidencia versionada** de la ejecución del gate para auditoría y trazabilidad.

## Logros
- Se documentó el **quality gate** en `ci/quality_gates.md` con cuatro checks explícitos:
  1. **Contrato de las APIs disponible** — El SUT expone su contrato (OpenAPI); oráculo: HTTP 200 y cuerpo con "openapi". Relacionado con R1 (Disponibilidad/Contrato).
  2. **Robustez ante entradas inválidas** — GET /api/pets/{id} con IDs inválidos no debe devolver HTTP 200. Relacionado con R2 (Robustez/HTTP 200).
  3. **Rendimiento/latencia** — GET /api/vets responde con HTTP 200; evidencia de latencia en entorno local (Semana 2). Relacionado con escenario Q2 (Performance - Local).
  4. **Casos sistemáticos** — Conjunto derivado por método, evaluado con oráculos; cualquier `FAIL` requiere explicación o acción. Relacionado con diseño de Semana 4 (`design/test_cases.md`, `design/reglas_oraculo.md`).
- Se implementó el gate ejecutable en **`ci/run_quality_gate.sh`**, que orquesta: arranque del SUT, healthcheck, captura de contrato, listado de vets, validación de entradas inválidas y ejecución de casos sistemáticos; luego consolida la evidencia en `evidence/week5/`.
- Se generó **evidencia estructurada**: RUNLOG.md (pasos y fecha), SUMMARY.md (resumen del gate), openapi.json, vets.json, invalid_ids.csv, invalid_pet_*.json, systematic_results.csv y systematic_summary.txt, permitiendo reproducibilidad y comparación histórica.
- Se mantuvo **trazabilidad** entre riesgos (S3), diseño y oráculos (S4), y criterios del gate (S5), con referencias explícitas en `ci/quality_gates.md`.

## Evidencia principal
| Tipo | Ubicación |
|------|-----------|
| Definición del quality gate (checks y oráculos) | `ci/quality_gates.md` |
| Script de ejecución del gate (local/CI) | `ci/run_quality_gate.sh` |
| Invocación vía Makefile | `make quality-gate` → genera `evidence/week5/` |
| Log de ejecución | `evidence/week5/RUNLOG.md` |
| Resumen del gate | `evidence/week5/SUMMARY.md` |
| Contrato API | `evidence/week5/openapi.json`, `openapi_http_code.txt` |
| Inventario vets | `evidence/week5/vets.json`, `vets_http_code.txt` |
| Entradas inválidas | `evidence/week5/invalid_ids.csv`, `invalid_pet_*.json` |
| Casos sistemáticos | `evidence/week5/systematic_results.csv`, `systematic_summary.txt` |
| CI workflow | `.github/workflows/ci.yml` |

## Retos y notas
- **Dependencia del estado del SUT:** el gate asume SUT levantado y saludable; `run_sut.sh` y `healthcheck_sut.sh` forman parte del flujo.
- **Reutilización de evidencia:** el script copia artefactos de week2 (contrato, vets, invalid_ids) y week4 (resultados sistemáticos) a week5 para centralizar la evidencia del gate en un solo directorio.
- **Criterio de éxito:** el gate no certifica “calidad total”; entrega evidencia reproducible y ayuda a frenar regresiones obvias según los riesgos priorizados.
- **Casos sistemáticos:** un `FAIL` en los resultados requiere explicación o acción del equipo; el gate deja la evidencia lista para esa revisión.

## Lecciones aprendidas
- Un quality gate efectivo debe reflejar riesgos de negocio (S3) y comportamiento técnico observable (S4), documentado en un único lugar (`ci/quality_gates.md`).
- Un script único en `ci/` que orquesta pasos y consolida evidencia en `evidence/week5/` simplifica la reproducción en local y en CI.
- Centralizar la evidencia del gate en un directorio por semana facilita auditoría, comparación entre corridas y publicación de artefactos.
- La trazabilidad explícita (riesgos → oráculos → checks → evidencia) permite justificar decisiones de aceptación/rechazo con evidencia.

## Próximos pasos
- Integrar `ci/run_quality_gate.sh` en el pipeline de CI (ejecución en cada cambio o en horarios definidos).
- Ajustar umbrales o checks con base en tendencia de fallos en corridas consecutivas (p. ej. robustez y casos sistemáticos).
- Incorporar criterios de latencia cuantitativos si se dispone de métricas estables (p. ej. percentiles).
- Formalizar criterios de salida por atributo de calidad y proponer mejoras al SUT cuando la evidencia lo justifique.
