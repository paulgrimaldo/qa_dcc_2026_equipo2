# Estrategia de Pruebas Basada en Riesgo (Semana 3)

## Propósito

Reducir la incertidumbre sobre la calidad del SUT (Spring Pet Clinic REST) cuando el tiempo de prueba es limitado, aplicando *risk-based testing*. La estrategia ordena los riesgos por severidad (impacto × probabilidad), exige trazabilidad **Riesgo → Escenario → Evidencia → Oráculo** y declara de forma explícita el **riesgo residual**.

## Alcance (por ahora)

**Incluido en esta etapa:**

- Comprobar que el contrato OpenAPI esté disponible y sea consumible (Q1).
- Medir una línea base de latencia local para GET /api/vets (Q2).
- Verificar que el SUT rechace entradas inválidas en GET /api/pets/{id} (Q3).

**Queda fuera de alcance por ahora:**

- Seguridad (autorización/autenticación), pruebas de carga o concurrencia, y SLOs en producción.
- Persistencia y consistencia funcional de todos los endpoints del backend.

## Top 3 riesgos priorizados (matriz: `risk/risk_matrix.csv`)

| Riesgo (ID) | Justificación | Escenario | Evidencia (Semana 3) | Oráculo mínimo | Riesgo residual |
|-------------|---------------|-----------|----------------------|----------------|-----------------|
| **R1:** Contrato OpenAPI no disponible | Sin contrato no hay consumo ni validación temprana; el servicio puede estar caído o /v3/api-docs no responde | Q1 | `evidence/week3/openapi.json` + `openapi_http_code.txt` | pass si HTTP 200 y el cuerpo contiene `"openapi"` | No se garantiza disponibilidad sostenida; solo un punto en el tiempo |
| **R2:** Entradas inválidas aceptadas como válidas en /api/pets/{id} | Puede ocultar defectos y llevar a estados incoherentes; la validación o el manejo de errores son insuficientes | Q3 | `evidence/week3/invalid_ids.csv` + `invalid_pet_*.json` | pass si **ningún** caso de ID inválido devuelve HTTP 200 | No se valida la semántica del error (400 vs 404); solo “no 200” |
| **R3:** Latencia alta o muy variable en GET /api/vets (local) | Probable en entorno local por recursos limitados, falta de warm-up o carga en el host; afecta la línea base y la comparabilidad | Q2 | `evidence/week3/latencia.csv` + `latency_summary.txt` (o `latencia_total.txt`) | pass si las mediciones devuelven HTTP 200; (opcional) p95 ≤ umbral definido | No se generaliza a producción ni se evalúa concurrencia |

## Reglas de evidencia (disciplina mínima)

- Toda la evidencia de la semana se almacena en `evidence/week3/` y se describe en `evidence/week3/RUNLOG.md`.
- Cada artefacto debe indicar **cómo se generó** (script o comando) y el **oráculo** aplicado (pass/fail).
- Si un script escribe en otra carpeta (p. ej. `week2`), se permite copiar los resultados a `week3` siempre que quede registrado en `RUNLOG.md`.

## Riesgo residual (declaración)

Aun mitigando R1–R3, persiste riesgo en seguridad, estabilidad bajo carga y validez externa (entorno local). Ese riesgo residual se acepta en esta etapa porque el objetivo del módulo es construir evidencia **reproducible y defendible** sobre escenarios básicos del backend Pet Clinic REST, antes de ampliar alcance o introducir concurrencia y entornos controlados.

## Validez (amenazas y límites)

- **Interna:** el warm-up o el estado del contenedor pueden afectar la latencia → mitigar descartando las primeras ejecuciones o reiniciando el SUT.
- **Constructo:** `time_total` en local es un proxy; no equivale al rendimiento en producción → declarar alcance como “línea base local”.
- **Externa:** hardware, red y configuración de Docker varían entre equipos → registrar el entorno (p. ej. en `memos/week3_memo.md`) y evitar generalizaciones fuertes.
