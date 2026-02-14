# Memo de Progreso — Semana 5
**Fecha:** 12/02/2026  
**Equipo:** Equipo 2  
**Semana:** 5 de 8

## Objetivos de la semana
- Definir un **quality gate** alineado con los riesgos priorizados en Semana 3.
- Convertir el gate en una ejecución reproducible tanto en entorno local como en CI.
- Generar y publicar evidencia de ejecución de Semana 5 como artefacto versionado.
- Mantener la trazabilidad entre riesgos (S3), diseño sistemático y oráculos/casos (S4), y decisiones de aceptación/rechazo (S5).

## Logros
- Se definió un **quality gate** explícito para el endpoint `GET /api/vets/{id}` que integra:
  - cumplimiento de oráculos mínimos (OR1–OR6);
  - registro de oráculos estrictos (OR7–OR9) como señal de calidad no bloqueante;
  - criterio de fallo inmediato ante respuestas 5xx en particiones inválidas (alineado con OR3).
- Se dejó el gate **ejecutable en local/CI** mediante script parametrizable (variables de entorno y salida estructurada), permitiendo reproducibilidad en distintos entornos del SUT.
- Se generó la **evidencia Week 5** y se publicó como **artifact** de ejecución (resultados agregados, resumen y evidencia por caso) para auditoría y comparación histórica.
- Se consolidó la **trazabilidad continua con Semana 4**, conectando:
  - riesgos priorizados (S3) → criterios de aceptación del gate;
  - oráculos/casos sistemáticos (S4) → veredictos automáticos del gate;
  - evidencia de resultados (S5) → insumos para decisiones de mejora del SUT y ajuste de pruebas.

## Evidencia principal
| Tipo | Ubicación |
|---|---|
| Definición del quality gate (criterios y umbrales) | `reports/week5_report.md` |
| Ejecución del gate local/CI | `scripts/quality_gate.sh` |
| Resultados agregados Week 5 | `evidence/week5/results.csv` |
| Resumen ejecutivo Week 5 | `evidence/week5/resumen.txt` |
| Evidencia por caso Week 5 | `evidence/week5/test_case_XX_response.json` |
| Artifact publicado (CI) | `artifacts/week5/` |

## Retos y notas
- **Dependencia del estado del SUT:** la existencia de recursos sigue afectando resultados de IDs válidos (>0), por lo que el gate conserva tolerancia controlada `{200,404}` para evitar falsos negativos.
- **Persistencia de errores 5xx en entradas inválidas:** estos casos permanecen como hallazgos críticos y se mantienen como condición bloqueante en el gate por su impacto en robustez.
- **Portabilidad de entornos:** se reforzó el uso de variables (`BASE_URL`, `ID_EXISTENTE`, `ID_INEXISTENTE`) para desacoplar la ejecución del entorno específico.
- **Equilibrio entre estrictitud y estabilidad:** OR7–OR9 siguen siendo no bloqueantes para no penalizar escenarios con alta variabilidad de datos, pero se conservan como alerta temprana.

## Lecciones aprendidas
- Un quality gate efectivo debe reflejar tanto riesgo de negocio (S3) como comportamiento técnico observable (S4).
- Separar criterios **bloqueantes** y **no bloqueantes** mejora la gobernanza de calidad sin frenar la entrega por ruido de entorno.
- La publicación de artefactos por corrida acelera revisiones de pares, auditoría y análisis comparativo entre semanas.
- La trazabilidad explícita entre semanas facilita justificar decisiones de aceptación/rechazo y priorizar mejoras con evidencia.

## Próximos pasos
- Ajustar umbrales del gate con base en tendencia de fallos (especialmente OR3 y OR5) en corridas consecutivas.
- Incorporar repetición automática para casos críticos y medir estabilidad (variación inter-ejecución/flakiness).
- Expandir cobertura con atributos adicionales (headers, roles, autenticación) y evaluar diseño combinatorio (por pares).
- Formalizar criterios de salida por atributo de calidad y preparar propuesta de mejora del SUT sobre manejo de errores inválidos.
