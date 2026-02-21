# Semana 6 — Gaming Drill del Quality Gate

## Táctica de gaming elegida

**Táctica:** **Manipulación de evidencia.**

Se modificará alguno de los scripts (por ejemplo los que alimentan el quality-gate o el Makefile) para **escribir directamente** en las rutas que espera el pipeline (`evidence/week5/` con los nombres de archivo que verifica el job `verify-evidence-files`). Así se falsea la ejecución real de los scripts: los archivos “existen” y el pipeline pasa, sin haber ejecutado los casos ni mejorado la calidad.

## Qué check afecta

El pipeline tiene **2 jobs**:

1. **`quality-gate-execution`** — Ejecuta `make quality-gate` y sube el artefacto `evidence/week5/`.
2. **`verify-evidence-files`** — Comprueba que existan en `evidence/week5/` los archivos listados (p. ej. `invalid_pet_abc.json`, `RUNLOG.md`, `SUMMARY.md`, `systematic_summary.txt`, etc.).

La táctica de manipulación de evidencia afecta sobre todo al **segundo job** (`verify-evidence-files`): si se escriben archivos (vacíos o con contenido ficticio) en esas rutas, el check de “existencia de archivos” pasa. Opcionalmente se puede también ajustar el flujo para que `quality-gate-execution` no falle (por ejemplo generando esos archivos en un paso previo o haciendo que el script “toque” las rutas esperadas sin ejecutar casos reales).

## Por qué “haría pasar” sin mejorar calidad

- El pipeline **no verifica el contenido ni la integridad** de la evidencia; solo que **existan** los archivos en las rutas esperadas.
- Al escribir directamente en `evidence/week5/` los nombres requeridos, el job `verify-evidence-files` da **OK** aunque la evidencia sea falsa o vacía.
- Si además se evita que falle `quality-gate-execution` (generando esos archivos desde un script o un target), todo el pipeline queda **verde** sin haber ejecutado pruebas reales ni mejorar la calidad del producto —es decir, se “gaming” el gate (Goodhart: el indicador pasa a ser el objetivo).

## Qué demuestra este drill
- **Before:** con un gate sin verificación de integridad, el bypass puede "pasar”.
- **After:** con verificación de integridad, el bypass queda **detectado** y el gate falla.

## Cómo ejecutar (local)
1) Asegúrate de tener Docker y `make`.
2) Ejecuta:
   - `make gaming-drill`
3) Revisa:
   - `evidence/week6/before/`
   - `evidence/week6/after/`
   - `evidence/week6/summary.txt`

## Artefactos protegidos por integridad (baseline)
- `scripts/systematic_cases.sh`
- `design/oracle_rules.md`
- `design/test_cases.md`