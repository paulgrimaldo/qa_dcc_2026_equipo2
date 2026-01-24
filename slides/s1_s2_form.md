# Plantilla de Presentación — Semanas 1 y 2 (Máx. 5 slides)

> **Regla:** máximo 5 “slides” (secciones).  
> **Tiempo total presentación:** 8-10 minutos.  

---

## Slide 1 — Semana 1 (Pregunta 1 + Respuesta 1)
**Pregunta 1:** ¿Qué tipo de evidencia de pruebas reduce incertidumbre sobre calidad sin confundir “testing” con “quality assurance”?


**Respuesta 1:**

 El Testing es un proceso que busca asegurar que el software funcione correctamente, a través de la prueba. La prueba lejos de garantizar un producto sin fallas actua como un revelador, por lo cual podemos decir que: “La prueba muestra la presencia de defectos no su ausencia”. La ISO 25010 es una norma que proporciona un modelo para evaluar la calidad, la misma define calidad como un conjuntos de aspectos que se pretenden evaluar para determinar esta denominada calidad del producto software. Entonces, la calidad no se prueba directamente y para reducir la incertidumbre va depender de los aspectos de Calidad que se deseen “probar” del software propuesto junto con la evidencia que aporten en cada aspecto que desee medir.


**Evidencia S1 (con oráculo + archivo):**
- Contrato accesible: **OpenAPI disponible**  
  - Oráculo: HTTP 200 + contiene `"openapi"`  
  - Evidencia: `evidence/week2/openapi.json`
- Operación básica: **Veterinarios y servicios responde**  
  - Oráculo: HTTP 200 + JSON bien formado  
  - Evidencia: `evidence/week2/vets.json`
- Manejo mínimo de error: **endpoint inexistente**  
  - Oráculo: HTTP 500  
  - Evidencia: (registro en el log del script o captura del código)
- Tiempo preliminar local (baseline):  
  - Oráculo: registrar `time_total` (sin afirmar producción)  
  - Evidencia: `evidence/week2/latencia_total.txt`

**Límite:**  
- No se garantiza seguridad ni ausencia de defectos solo apunta a disponibilidad/contrato/operación mínima en entorno local.”

---

## Slide 2 — Semana 2 (Pregunta 2 + Respuesta 2)
**Pregunta 2:** ¿Cómo convertir “calidad” en afirmaciones falsables y medibles?

**Respuesta 2:**


La calidad de software no es falsable cuando se expresa de manera general, por ejemplo, afirmando que un sistema “es de buena calidad”, ya que este tipo de enunciados carece de criterios objetivos de verificación. Para convertir la calidad de software en afirmaciones falsables y medibles, es necesario descomponerla en atributos específicos como funcionalidad, confiabilidad, eficiencia de desempeño, usabilidad, seguridad y mantenibilidad. Cada uno de estos atributos debe definirse mediante métricas cuantificables y criterios claros de aceptación, tales como tiempos de respuesta máximos, tasas de fallos permitidas, porcentaje de cobertura de pruebas o nivel de satisfacción del usuario. De esta forma, la calidad del software se transforma en un conjunto de afirmaciones verificables empíricamente, que pueden confirmarse o refutarse a partir de datos observables obtenidos mediante pruebas y mediciones.



**2 escenarios estrella (de `quality/scenarios.md`):**
- **Escenario A — Latencia básica de Veterinarios y servicios (Performance local)**  
  - Estímulo: GET `/api/vets`  
  - Entorno: local, Docker, 30 repeticiones consecutivas  
  - Respuesta: HTTP 200 + JSON  
  - Medida: `time_total` por corrida (y p95 reportado)  
  - Evidencia: `evidence/week2/latencia.csv` + `evidence/week2/latencia_total.txt`  
  - Falsación: tiempos exceden umbral propuesto o falla HTTP 200
- **Escenario B — Robustez ante IDs inválidos en `/api/pets/{id}`**  
  - Estímulo: IDs inválidos (-1, 0, 999999, abc)  
  - Entorno: local, sin carga, 1 ejecución por caso  
  - Respuesta: no retornar 200 para entradas inválidas  
  - Medida: `http_code` por caso  
  - Evidencia: `evidence/week2/invalid_ids.csv` + `evidence/week2/pet_<id>.json`  
  - Falsación: si algún caso devuelve HTTP 200, el escenario queda refutado

**Mini-tabla (obligatoria):**
| Claim | Escenario | Métrica | Evidencia (archivo) | Oráculo (pass/fail) |
|---|---|---|---|---|
| Contrato accesible | Q1-CapturarContratoApi | HTTP + contiene `"openapi"` | `evidence/week2/openapi.json`, `openapi_http_code.txt` | pass si `200` y contiene `"openapi"` |
| Tiempo local preliminar | Q2-Latencia (30 runs) | `time_total` por run (p95) | `evidence/week2/latencia.csv`, `latencia_total.txt` | pass si HTTP 200 + (opcional) p95<=X |
| Entradas inválidas no aceptadas | Q3-ValidarInputs | `http_code` por caso | `evidence/week2/invalid_ids.csv`, `invalid_pet_<id>.json` | pass si todos `http_code != 200` |
---

## Slide 3 — Método formalizado (¿cómo trabajamos para definir escenarios?.)
**Proceso aplicado:**
1) Definimos claims acotados (disponibilidad mínima, robustez, baseline de latencia).  
2) Los expresamos como escenarios (E–Entorno–R–Medida) en `quality/scenarios.md`.  
3) Definimos oráculos mínimos (HTTP 200/500, JSON válido, HTTP != 200).  
4) Generamos evidencia reproducible con scripts y la versionamos en `evidence/week2`.
5) Se definió scripts de automatización para cubrir todos los escenarios desc

**Fuentes para definición de método:**
- ISTQB: oráculo y objetivos de prueba (criterio de pass/fail).  
- SWE@Google: testing como reducción de riesgo y claridad de pruebas.  
- arc42/ATAM: escenarios medibles y verificables (no adjetivos).
- ISO 25010 Modelos de Calidad

---

## Slide 4 — Amenazas a la validez 
- **Interna:** warm-up/caché del contenedor afecta latencia → Mitigación: descartar primeras N corridas o reiniciar antes de medir.  
- **Constructo:** latencia local es proxy (no producción) → Mitigación: declarar el alcance “local baseline” y no extrapolar.  
- **Externa:** resultados dependen de máquina/red → Mitigación: registrar entorno (CPU/RAM/Docker) y repetir en otra máquina, considerando que la imagen base de docker se ejecuta en el puerto 9966.  

---

## Slide 5 — Cierre (2 conclusiones)
- **Evidencia más fuerte:** robustez IDs inválidos. Un 200 refuta el escenario.  
- **Límite más crítico:** mediciones locales no generalizan a producción (validez externa).  
- **Mejora concreta (sin implementar hoy):** Mejorar el código de estado HTTP de 500 a 404 ante ruta no existentes para adecuarse a los estandares web. 
---
