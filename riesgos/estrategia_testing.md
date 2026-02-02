# Estrategia de Pruebas Basada en Riesgo (Semana 3)

## Propósito

Reducir la incertidumbre sobre la calidad del SUT (Spring Pet Clinic REST) cuando el tiempo de prueba es limitado, aplicando *risk-based testing*. La estrategia ordena los riesgos por severidad (impacto × probabilidad), exige trazabilidad **Riesgo → Escenario → Evidencia → Oráculo** y declara de forma explícita el **riesgo residual**.

## Alcance

**Incluido en esta etapa:**

- Comprobar que el contrato OpenAPI esté disponible y sea consumible (Q1).
- Medir una línea base de latencia local para GET /api/vets (Q2).
- Verificar que el SUT rechace entradas inválidas en GET /api/pets/{id} (Q3).

**Queda fuera de alcance:**

- Seguridad como ser autorización y/o autenticación
- Pruebas de carga
- Pruebas de concurrencia
- SLOs en producción
- Persistencia y consistencia funcional de todos los endpoints del backend.

## Top 3 riesgos priorizados

| Riesgo (ID) | Justificación | Escenario | Evidencia (Semana 3) | Oráculo mínimo | Riesgo residual |
|-------------|---------------|-----------|----------------------|----------------|-----------------|
| **R1 (Disponibilidad):** El contrato OpenAPI del SUT Pet Clinic Rest no está disponible porque el servicio se encuentra caído o el endpoint /v3/api-docs no responde | Impacto máximo sin contrato no existe consumo ni validación; probabilidad media debido a dependencias de Docker y del puerto (p. ej. SUT no iniciado, puerto ocupado o contenedor detenido) | Q1 | `evidence/week3/openapi.json`; `evidence/week3/openapi_http_code.txt` | pass si HTTP 200 y el cuerpo contiene `"openapi"` | No se garantiza disponibilidad sostenida; solo un punto en el tiempo |
| **R2 (Robustez):** El SUT considera válidas entradas incorrectas en GET /api/pets/{id} y responde con HTTP 200 cuando no corresponde | Puede ocultar errores en etapas posteriores con probabilidad media debido a la validación limitada observada; la validación es insuficiente o el manejo de errores es inconsistente en el endpoint de mascotas | Q3 | `evidence/week3/invalid_ids.csv`; `evidence/week3/invalid_pet_*.json` | pass si **ningún** caso de ID inválido devuelve HTTP 200 | No se valida la semántica del error (400 vs 404); solo “no 200” |
| **R3 (Rendimiento):** Se observa latencia alta o muy variable en GET /api/vets dentro del entorno local | Probabilidad alta por la variación del entorno local; impacto moderado al tratarse de línea base local y no de producción. Causas: recursos locales limitados, falta de warm-up adecuado o carga en el host | Q2 | `evidence/week3/latencia.csv`; `evidence/week3/latencia_total.txt` | pass si las mediciones devuelven HTTP 200; (opcional) p95 ≤ umbral definido | No se generaliza a producción ni se evalúa concurrencia |

## Reglas de evidencia

- Toda la evidencia de la semana se almacena en `evidence/week3/` y se describe en `evidence/week3/RUNLOG.md`.
- Cada artefacto indica **cómo se generó** (script o comando) y el **oráculo** aplicado (pass/fail).
- Los scripts ejecutados para las validaciones de `week3` escriben en `week2`, se decidió copiar los resultados a `week3` y añadir aclaraciones en `RUNLOG.md`.

## Riesgo residual

Aunque se mitiguen R1–R3, persiste riesgo en seguridad, estabilidad bajo carga y validez externa (entorno local). 

Se acepta como riesgo residual por que el proposito el crear evidencias **reproducible y defendible** sobre escenarios básicos del backend Pet Clinic REST, antes de ampliar alcance o introducir concurrencia y entornos controlados.

## Validez

- **Interna:** warm-up/caché del contenedor afecta latencia → Mitigación: descartar primeras N corridas o reiniciar antes de medir.  
- **Constructo:** latencia local es proxy (no producción) → Mitigación: se ha declarado como local y no como entorno de producción 
- **Externa:** 
  - resultados dependen de máquina/red → Mitigación: registrar entorno (CPU/RAM/Docker) y repetir en otra máquina, considerando que la imagen base de docker se ejecuta en el puerto 9966.  
  - Por defecto el proyecto levanta una Base de datos en memoria y requiere configuración manual para levantar otro tipo de bases de datos (postgreSQL, MySQL)
