# Plantilla de Presentación — Semanas 1 y 2 (Máx. 5 slides)

> **Regla:** máximo 5 “slides” (secciones).  
> **Tiempo total presentación:** 8-10 minutos.  

---

## Slide 1 — Semana 1 (Pregunta 1 + Respuesta 1)
**Pregunta 1:** ¿Qué tipo de evidencia de pruebas reduce incertidumbre sobre calidad sin confundir “testing” con “quality assurance”?


**Respuesta 1:**

 El Testing es un proceso que busca asegurar que el software funcione correctamente, a través de la prueba. La prueba lejos de garantizar un producto sin fallas actua como un revelador, por lo cual podemos decir que: “La prueba muestra la presencia de defectos no su ausencia”. La ISO 25010 es una norma que proporciona un modelo para evaluar la calidad, la misma define calidad como un conjuntos de aspectos que se pretenden evaluar para determinar esta denominada calidad del producto software. Entonces, la calidad no se prueba directamente y para reducir la incertidumbre va depender de los aspectos de Calidad que se deseen “probar” del software propuesto junto con la evidencia que aporten en cada aspecto que desee medir.


**Evidencias planeadas (cada uno con oráculo + archivo):**
- CapturarContratoApi: **OpenAPI disponible**  
  - Oráculo: HTTP 200 + contiene `"openapi"`  
  - Evidencia: `evidence/week2/openapi.json`
- Operación básica: **Inventario responde**  
  - Oráculo: HTTP 200 + JSON bien formado  
  - Evidencia: `evidence/week2/inventory.json`
- Manejo mínimo de error: **endpoint inexistente**  
  - Oráculo: HTTP 404  
  - Evidencia: (registro en el log del script o captura del código)
- Tiempo preliminar local (baseline):  
  - Oráculo: registrar `time_total` (sin afirmar producción)  
  - Evidencia: `evidence/week2/latency_summary.txt`

**Límite (1 línea):**  
- ___ (qué NO demuestra esta evidencia)

---

## Slide 2 — Semana 2 (Pregunta 2 + Respuesta 2)
**Pregunta 2:** ¿Cómo convertir “calidad” en afirmaciones falsables y medibles?

**Respuesta 2:**


La calidad de software no es falsable cuando se expresa de manera general, por ejemplo, afirmando que un sistema “es de buena calidad”, ya que este tipo de enunciados carece de criterios objetivos de verificación. Para convertir la calidad de software en afirmaciones falsables y medibles, es necesario descomponerla en atributos específicos como funcionalidad, confiabilidad, eficiencia de desempeño, usabilidad, seguridad y mantenibilidad. Cada uno de estos atributos debe definirse mediante métricas cuantificables y criterios claros de aceptación, tales como tiempos de respuesta máximos, tasas de fallos permitidas, porcentaje de cobertura de pruebas o nivel de satisfacción del usuario. De esta forma, la calidad del software se transforma en un conjunto de afirmaciones verificables empíricamente, que pueden confirmarse o refutarse a partir de datos observables obtenidos mediante pruebas y mediciones.



**Escenarios S2 (elige 2 “estrella”):**
- Escenario A: E: ___ | Entorno: ___ | R: ___ | Medida: ___ | Evidencia: `evidence/week2/...` | Falsación: ___  
- Escenario B: E: ___ | Entorno: ___ | R: ___ | Medida: ___ | Evidencia: `evidence/week2/...` | Falsación: ___  

**Mini-tabla (obligatoria):**
| Claim | Escenario | Métrica | Evidencia (archivo) | Oráculo (pass/fail) |
|---|---|---|---|---|
| ___ | ___ | ___ | ___ | ___ |
| ___ | ___ | ___ | ___ | ___ |

---

## Slide 3 — Método formalizado (¿cómo trabajamos para definir escenarios?.)
**Proceso aplicado:**
1) . 
2) . 
3) . 
4) . 

**Fuentes para definición de método:**
- ...
- ...


---

## Slide 4 — Amenazas a la validez 
**Amenazas a la validez (mínimo 3) + mitigación futura:**
- Interna: ___ → Mitigación: ___  
- Constructo: ___ → Mitigación: ___  
- Externa: ___ → Mitigación: ___  

*Revisar artículo: "Amenazas a la validez"*


---

## Slide 5 — Cierre (2 conclusiones)
- **Evidencia más fuerte:** ___ (por qué reduce incertidumbre)  
- **Límite más crítico:** ___ (por qué impide generalizar)  
- **Siguiente mejora concreta:** ___ (sin implementar hoy)

---
