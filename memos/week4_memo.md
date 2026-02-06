# Memo de Progreso — Semana 4

**Fecha:** 5/02/2026  
**Equipo:** Equipo 2  
**Semana:** 4 de 8

---

## Objetivos de la semana

- Seleccionar un endpoint del SUT como objeto de prueba.
- Diseñar casos de prueba sistemáticos (EQ/BV o combinatoria) y definir reglas de oráculo.
- Implementar ejecución reproducible para generar evidencia versionada.
- Documentar el método y los límites (validez) del diseño.

---

## Logros

- **Endpoint seleccionado:** `GET /api/vets/{id}` (Spring Petclinic, base URL configurable).
- **Oráculos definidos:** 9 reglas (OR1–OR9) documentadas en `design/reglas_oraculo.md`:
  - mínimas (OR1–OR4): ejecución, Content-Type JSON, manejo de errores;
  - por partición (OR5–OR6): IDs inválidos vs válidos;
  - estrictas (OR7–OR9): cuerpo no vacío, consistencia semántica, idempotencia (no bloqueantes).
- **Casos sistemáticos diseñados:** 19 casos derivados de EQ/BV sobre el parámetro `{id}`, documentados en `design/test_cases.md` (particiones P1 no numérico, P2 ≤0, P3 >0; valores límite; formatos especiales e idempotencia).
- **Ejecución reproducible implementada:** script `scripts/casos_sistematicos.sh` con variables `BASE_URL`, `ID_EXISTENTE`, `ID_INEXISTENTE` para adaptar el entorno.
- **Evidencia week4 generada:** carpeta `evidence/week4/` con `results.csv`, `resumen.txt` y 19 archivos `test_case_XX_response.json` por caso.
- **Reporte metodológico producido:** `reports/week4_report.md` con objeto de prueba, técnica de diseño, oráculos, cobertura afirmada, amenazas a la validez y evidencia.

---

## Evidencia principal

| Tipo | Ubicación |
|------|-----------|
| Reglas de oráculo | `design/reglas_oraculo.md` |
| Casos sistemáticos | `design/test_cases.md` |
| Script de ejecución | `scripts/casos_sistematicos.sh` |
| Resultados agregados | `evidence/week4/results.csv` |
| Resumen ejecutivo | `evidence/week4/resumen.txt` |
| Evidencia por caso | `evidence/week4/test_case_XX_response.json` (19 archivos) |
| Reporte metodológico | `reports/week4_report.md` |

**Última ejecución:** 19 casos; 12 pass y 7 fail bajo oráculo mínimo.

---

## Retos y notas

- **Variación por estado del SUT:** un ID numérico >0 puede devolver 200 o 404 según la existencia del veterinario en BD. Los oráculos mínimos permiten `{200, 404}` para P3 para evitar falsos negativos.
- **Respuestas 5xx en entradas inválidas:** varios casos P1 y P2 devuelven 500 en lugar de 404/400; OR3 se aplica como “no 5xx” coherente con la partición, y los fallos se registran como `OR3_fail_5xx`.
- **Inconsistencias detectadas:** `test_case_13` (` 1 ` con espacios) retornó 200 cuando OR5 esperaba código distinto; `-2147483648` (Integer.MIN) retornó 500, lo que expone diferencias en el manejo de errores del SUT.
- **Oráculos estrictos:** OR7–OR9 se evalúan pero no bloquean; se reportan en `notes` como `STRICT_PASS` / `STRICT_FAIL` / `NOT_EVALUATED`.

---

## Lecciones aprendidas

- El diseño sistemático (EQ/BV) hace explícitos los supuestos y reduce la arbitrariedad en la selección de casos.
- Separar oráculos mínimos vs estrictos mantiene la falsabilidad sin depender de datos no controlados ni de la existencia de recursos concretos.
- La evidencia por caso (`*_response.json`) más resultados agregados (`results.csv`, `resumen.txt`) facilita la revisión, auditoría y análisis de fallos.
- Variables de entorno (`ID_EXISTENTE`, `ID_INEXISTENTE`) permiten adaptar la ejecución a distintos entornos sin modificar el script.
- Los fallos observados (5xx, 200 inesperado) proporcionan insumos concretos para discutir mejoras en el SUT o ajustes en los oráculos.

---

## Próximos pasos (Semana 5)

*(Sugerencias a discutir con el equipo)*

- Integrar el diseño sistemático con la priorización por riesgo (Semana 3) y ampliar cobertura por atributos.
- Introducir criterios de estabilidad (repetición) para casos críticos y evaluar flakiness.
- Definir criterios de salida (*exit criteria*) para cada atributo de calidad priorizado.
- Aprovechar los fallos detectados (OR3, OR5) para proponer mejoras o ajustes de oráculos en iteraciones futuras.

---

**Preparado por:** Equipo 2  
**Próxima revisión:** Semana 5
