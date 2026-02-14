??# Quality Gates

## Propósito
Ejecutar un conjunto **mínimo y confiable** de chequeos automatizados en cada cambio para reducir incertidumbre sobre los **riesgos priorizados** (Semana 3) usando oráculos y casos sistemáticos (Semana 4).
Este gate **no** pretende certificar “calidad total”, sino entregar **evidencia reproducible** y frenar regresiones obvias.

## Checks del gate 
1) **Contrato disponible (Disponibilidad contrato OpenAPI )**
- Claim: el SUT Pet Clinic Rest expone su contrato.
- Evidencia: evidence/week5/openapi.json; evidence/week5/openapi_http_code.tx
- Oráculo: pass si HTTP 200 y el cuerpo contiene "openapi".
- Relación: semana 3 `riesgos/estrategia_testing.md` (R1 Disponibilidad/Contrato).

2) **Robustez ante entradas inválidas**
- Claim: entradas en GET /api/pets/{id}, responde con HTTP 200  y cuando no corresponde codigo !=200 .
- Evidencia: evidence/week5/invalid_ids.csv; evidence/week5/invalid_pet_*.json
- Oráculo: pass si ningún caso de ID inválido devuelve HTTP 200
- Relación: semana 3 `riesgos/estrategia_testing.md` (R2 Robustez/HTTP 200).


3) **Rendimiento latencia alta o muy variable en GET /api/vets dentro del entorno local**
- Claim: se solicita GET /api/vets.
- Evidencia: evidence/week2/latencia.csv y evidence/week2/latencia_total.txt
- Oráculo: responde con HTTP 200.
- Relación: Semana 2 / Escenario Q2 — Latencia básica del endpoint de Veterinarios y Servicios (Performance - Local).


4)**Casos sistemáticos (Semana 4)**
- Claim: conjunto sistemático derivado por método, evaluado con oráculos explícitos.
- Evidencia: `evidence/week5/results.csv` y `evidence/week5/resumen.txt`
- Oráculo: el script produce resumen y evidencia; cualquier `FAIL` requiere explicación/acción del equipo.
- Relación: `design/test_cases.md` y `design/reglas_oraculo.md`.

## Alta señal / bajo ruido (confiabilidad)
- El gate debe preferir checks **deterministas** (códigos HTTP, JSON bien formado, oráculos explícitos).
- Evitar depender de métricas sensibles al entorno (p. ej., umbrales estrictos de latencia) como criterio de fallo.
- Mantener evidencia trazable: **riesgo → escenario → evidencia → oráculo**.

## Cómo ejecutar localmente (equivalente a CI)
- `make quality-gate` (genera `evidence/week5/`).


