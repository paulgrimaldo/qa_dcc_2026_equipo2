# Reporte Semana 4 — Diseño sistemático de pruebas y oráculos (Petclinic)

## 1) Objeto de prueba

**Endpoint:** `GET /api/vets/{id}` (Spring Petclinic).

**Base URL configurable:** por defecto `http://localhost:9966/petclinic`; el script permite sobrescribir `BASE_URL` para adaptar el entorno.

**Motivación:** el parámetro de ruta `{id}` permite diseñar casos sistemáticos por **clases de equivalencia** y **valores límite**, y observar la robustez y consistencia del manejo de entradas (válidas, inválidas y extremas) sin depender de un catálogo fijo de veterinarios en la base de datos.

---

## 2) Técnica de diseño utilizada

**Equivalencia (EQ) + Valores Límite (BV)** sobre el parámetro `{id}`.

- **EQ:** se particiona el dominio del parámetro en clases relevantes:
  - **P1 — No numérico:** cadenas como `abc`, `1.5`, espacios (` 1 `), overflow numérico (`9223372036852`), URL-encoded (`%31`).
  - **P2 — Numérico ≤ 0:** `0`, `-1`, `-2147483648` (Integer.MIN).
  - **P3 — Numérico > 0:** `1`, `2`, `999999`, `2147483647` (Integer.MAX), variantes de formato (`0001`, `01`, `+1`), y IDs configurables para existencia/inexistencia e idempotencia.

- **BV:** se ejercitan puntos cercanos al límite (`-1`, `0`, `1`), IDs grandes (`999999`, `999999999`), extremos de entero (`2147483647`, `-2147483648`) y un caso de idempotencia (múltiples llamadas con el mismo `{id}`).

La justificación es metodológica: se evita inventar casos ad hoc y se hace explícito el criterio de selección de entradas, facilitando trazabilidad y repetición.

---

## 3) Oráculos (mínimos vs estrictos)

Las reglas están definidas en `design/reglas_oraculo.md`.

### Reglas mínimas (siempre evaluadas)

- **OR1 (Ejecución):** Todas las solicitudes registran `http_code` y persisten el cuerpo de la respuesta como evidencia.
- **OR2 (Cuerpo de la respuesta):** La respuesta no debe ser HTML (verificación mediante cabecera `Content-Type=application/json`).
- **OR3 (Formato de errores):** Según las reglas de diseño, 404 ante ausencia del recurso y 500 ante otros errores; en la ejecución se evalúa que no se produzcan respuestas 5xx en solicitudes controladas y que los códigos sean coherentes con la partición.
- **OR4 (JSON válido cuando no hay 500):** Si `http_code ≠ 500`, el cuerpo debe ser JSON válido (y coherente con `Content-Type`).

### Reglas por partición

- **OR5 (ID inválido no aceptado):** Si `{id}` es no numérico o numérico ≤ 0, la respuesta **no** debe ser `200`.
- **OR6 (ID numérico válido):** Si `{id}` es numérico y > 0, `http_code` debe estar en `{200, 404}`.

### Oráculos estrictos (opcionales, no bloqueantes)

- **OR7:** Si `http_code == 200`, el cuerpo no debería ser un JSON vacío `{}`.
- **OR8:** Si `http_code == 200`, el cuerpo debería incluir el campo `"id"` (idealmente coherente con el `{id}` solicitado).
- **OR9 (Idempotencia):** En ejecuciones secuenciales con el mismo `{id}` (p. ej. 5 repeticiones), todas las respuestas deben ser equivalentes.

En el script, OR7–OR9 se registran en `notes` como `STRICT_PASS` / `STRICT_FAIL` / `NOT_EVALUATED` y no cambian el resultado mínimo (pass/fail) del caso.

---

## 4) Cobertura afirmada (y lo que NO se afirma)

**Se afirma:**

- Cobertura sistemática de las clases de entrada del parámetro `{id}` (EQ) y de los límites y formatos relevantes (BV), incluyendo variantes de formato, signo y idempotencia.
- Evidencia reproducible por caso: código HTTP, cuerpo guardado en `evidence/week4/<test_case_id>_response.json`, y decisión pass/fail bajo oráculo mínimo en `results.csv`.
- Resumen ejecutivo en `evidence/week4/resumen.txt` (total de casos, pass/fail con oráculo mínimo).

**No se afirma:**

- Correctitud funcional completa del recurso `vets` (depende de datos existentes y de la lógica de negocio no ejercitada).
- Que el SUT cumpla estrictamente OR3 tal como está redactado en reglas (p. ej. “404 ante ausencia y 500 ante cualquier otro error”); el oráculo mínimo aplicado en el script prioriza “no 5xx” y coherencia de códigos para las particiones.
- Seguridad, concurrencia ni rendimiento en producción.
- Estabilidad temporal a largo plazo (requiere repetición controlada y monitoreo).

---

## 5) Amenazas a la validez (interno / constructo / externo)

- **Interna:** El estado y los datos del SUT (veterinarios existentes) pueden cambiar; un mismo `{id}` puede pasar de 200 a 404 o viceversa entre ejecuciones.  
  *Mitigación:* uso de oráculos que no dependen de la existencia del recurso (se permite 200 o 404 para P3); casos con `ID_EXISTENTE` e `ID_INEXISTENTE` configurables por variables de entorno (`ID_EXISTENTE`, `ID_INEXISTENTE`) para adaptar a un entorno conocido.

- **Constructo:** Usar códigos HTTP y formato JSON como proxy de “robustez” no cubre otras dimensiones (seguridad, integridad semántica completa, accesibilidad).  
  *Mitigación:* declarar explícitamente el alcance del atributo evaluado (manejo de entradas y consistencia de formato de respuesta).

- **Externa:** Los resultados dependen del entorno (Docker/local, red, versión del SUT y de la BD).  
  *Mitigación:* registrar entorno y versión del SUT; repetir en otra máquina o instancia si se requiere generalización; el script permite `BASE_URL` para distintos despliegues.

---

## 6) Evidencia

| Elemento        | Ubicación |
|-----------------|-----------|
| Casos de prueba | `design/test_cases.md` |
| Reglas de oráculo | `design/reglas_oraculo.md` |
| Script de ejecución | `scripts/casos_sistematicos.sh` |
| Evidencia por caso | `evidence/week4/<test_case_id>_response.json` (o `.txt` si la respuesta no es JSON) |
| Resultados agregados | `evidence/week4/results.csv` (columnas: tc_id, input_id, partition, http_code, oracle_pass, notes, response_file) |
| Resumen ejecutivo | `evidence/week4/resumen.txt` |

**Resumen de la última ejecución (referencia):** 19 casos ejecutados; 12 pass y 7 fail bajo oráculo mínimo. Los fallos se concentran en particiones P1 y P2 (respuestas 5xx o 200 inesperado), y en un caso P3 con ID inexistente que devolvió 500, lo que permite discutir mejoras en el manejo de errores del SUT o en el ajuste de oráculos/expectativas.

---

**Validez y límites del diseño (resumen):** El diseño aporta una *operacionalización verificable* del manejo de entradas en un endpoint REST (clases de equivalencia y límites sobre el parámetro de ruta) y oráculos escalonados (mínimos defendibles sin datos de referencia, estrictos opcionales). La argumentación es válida en la medida en que se acota el constructo evaluado (comportamiento observable vía HTTP/JSON) y se declaran explícitamente las amenazas y lo que no se afirma, permitiendo replicación y extensión a otros recursos o contextos.
