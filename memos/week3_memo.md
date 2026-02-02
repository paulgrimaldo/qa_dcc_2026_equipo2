# Memo de Progreso - Semana 3

**Fecha**: 31/01/2026  \
**Equipo**: Equipo X  \
**Semana**: 3 de 8

## Objetivos de la semana
- Construir una matriz de riesgos de calidad del SUT (impacto × probabilidad) y seleccionar Top 3.
- Definir una estrategia mínima de pruebas basada en riesgo: **Riesgo → Escenario → Evidencia → Oráculo**.
- Generar y versionar evidencia para los Top 3 riesgos y registrar su reproducibilidad.

## Logros
- Matriz de riesgos creada en `riesgos/matriz_riesgos.csv` con 8 riesgos y priorización Top 3 (R1–R3).
- Estrategia basada en riesgo documentada en `riesgos/estrategia_testing.md`, incluyendo alcance, riesgo residual y validez.
- Evidencia para Top 3 riesgos generada y organizada en `evidence/week3/`, con trazabilidad registrada en `evidence/week3/RUNLOG.md`.

## Evidencia principal
- Matriz de riesgos y priorización: `riesgos/matriz_riesgos.csv`.
- Estrategia basada en riesgo: `riesgos/estrategia_testing.md`.
- Evidencias Top 3 (Semana 3):
  - Contrato/Disponibilidad: `evidence/week3/openapi.json`, `openapi_http_code.txt`. (Alcides)
  - Robustez inputs inválidos: `evidence/week3/invalid_ids.csv`, `invalid_pet_*.json`. (Paul)
  - Latencia baseline local: `evidence/week3/latencia.csv`, `latencia_total.txt`.(Alcides) 
  - Trazabilidad de ejecución: `evidence/week3/RUNLOG.md`.(Paul)

## Retos y notas
- Scripts actuales escriben evidencia en `evidence/week2/`; para mantener trazabilidad semanal se copió a `week3` y se documentó en `RUNLOG.md`.
- Variabilidad de latencia en entorno local: warm-up/caché y carga del host pueden sesgar mediciones.
- Oráculo mínimo “HTTP != 200” 

## Lecciones aprendidas
- La priorización por riesgo permite justificar **qué se prueba primero** y por qué, incluso con evidencia mínima.
- Sin trazabilidad explícita (archivo + comando + oráculo) la evidencia pierde valor para revisión por terceros.
- Declarar riesgo residual evita conclusiones fuertes fuera del alcance (p.ej. producción/carga).

## Próximos pasos (Semana 4) - (Potenciales pasos, a ser discutidos con el equipo)
- a la espera de revision Grupal y analisar el contenido para la siguiente semana


---

**Preparado por**: Equipo X  \
**Próxima revisión**: Semana 4