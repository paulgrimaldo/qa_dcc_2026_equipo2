# RUNLOG — Semana 3

**Fecha**: 2026-01-31  
**SUT**: Spring Pet Clinic REST (Docker local, puerto 9966)  
**Objetivo**: generar evidencia para los Top 3 riesgos (R1–R3) priorizados en `riesgos/matriz_riesgos.csv` y descritos en `riesgos/estrategia_testing.md`.

## Comandos ejecutados (reproducibles)
> Los scripts del repositorio escriben por defecto en `evidence/week2/`. Para la entrega de Semana 3 se **copiaron** los artefactos generados a `evidence/week3/`, manteniendo la misma ejecución y documentando aquí la trazabilidad.

1) **Disponibilidad del contrato OpenAPI** (Q1 / Riesgo R1)
- Comando: `./scripts/capturarContratoApi.sh`
- Oráculo: respuesta HTTP 200 y cuerpo que contiene `"openapi"`.
- Artefactos: `openapi.json`, `openapi_http_code.txt`

2) **Robustez ante entradas inválidas en GET /api/pets/{id}** (Q3 / Riesgo R2)
- Comando: `./scripts/validarInputs.sh`
- Oráculo: ningún caso de ID inválido debe devolver HTTP 200.
- Artefactos: `invalid_ids.csv`, `invalid_pet_*.json`

3) **Línea base de latencia local para GET /api/vets** (Q2 / Riesgo R3)
- Comando: `./scripts/revisarLatencia.sh [N]` (p. ej. `./scripts/revisarLatencia.sh 15`; N opcional, por defecto 15).
- Oráculo: registrar tiempos de respuesta y comprobar que el SUT responde HTTP 200 durante las mediciones.
- Artefactos: `latencia.csv`, `latencia_total.txt`

## Copia a carpeta de semana
- Acción: `cp -r evidence/week2/* evidence/week3/`
- Motivo: trazabilidad de entregables por semana sin modificar los scripts en esta iteración.