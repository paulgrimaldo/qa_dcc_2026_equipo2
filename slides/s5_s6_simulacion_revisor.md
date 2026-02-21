# Evaluación de Propuesta - Equipos 2 y 5

**Propuesta evaluada:** B — Empresa: AtlasQA Partners
**Veredicto:** Aceptar con condiciones

---

## Slide 1 — Qué ofrece la propuesta

- Objetivo declarado: "Reducir riesgo de manera rápida y sostener calidad 
  continua mediante automatización progresiva."
  **Referencia:** Sección 1

- Alcance / exclusiones:
  - Incluye escenarios (≥8), matriz Top 3, casos sistemáticos (≥12), 
    gate CI con artifacts y guía operativa. **Ref:** Sección 3
  - Excluye pruebas avanzadas de seguridad y performance a escala 
    producción. **Ref:** Sección 3

- Entregables principales:
  - Gate CI con checks críticos y artifacts publicados. **Ref:** Sección 9
  - Pack sistemático y oráculos documentados. **Ref:** Sección 9
  - Estrategia por riesgo y riesgo residual reportado. **Ref:** Sección 9

---

## Slide 2 — Fortalezas

- F1: Transición controlada de checks informativos a bloqueantes.
  **Evidencia:** Sección 4 (Fase 4) y Sección 5
  **Por qué es valioso:** Reduce fricción inicial con desarrollo, 
  permitiendo establecer baseline antes de bloquear pases a producción.

- F2: Uso de técnicas formales de diseño (EQ, BV, Pairwise).
  **Evidencia:** Sección 4 (Fase 3)
  **Por qué es valioso:** Garantiza cobertura sistemática y eficiente 
  para el Top 3 de riesgos, minimizando redundancia de casos.

- F3: Diferenciación de oráculos mínimos vs. estrictos.
  **Evidencia:** Sección 4 (Fase 3)
  **Por qué es valioso:** Optimiza mantenimiento reduciendo falsos 
  positivos en escenarios generales, reservando rigor para flujos críticos.

- F4: Declaración explícita de riesgo residual.
  **Evidencia:** Sección 4 (Fase 2)
  **Por qué es valioso:** Hace visible lo que el programa no cubre, 
  permitiendo decisiones informadas de negocio.

- F5: Enfoque basado en riesgo y trazabilidad. **Evidencia**: Sección 4, Fase 2 y 3. **Por qué es valioso:** Permite justificar técnicamente qué se prueba primero y asegura que cada prueba responda a un riesgo de negocio.

---

## Slide 3 — Debilidades / riesgos

- D1 (Severidad: Crítica): Aceptar el segundo resultado del pipeline 
  como referencia válida para "no detener el flujo".
  **Sección:** Sección 6
  **Riesgo:** Enmascara defectos intermitentes, destruyendo la 
  confiabilidad del Quality Gate (falso verde sistemático).

- D2 (Severidad: Mayor): Estimación de probabilidad basada únicamente 
  en consenso sin heurísticas ni datos de respaldo.
  **Sección:** Sección 4 (Fase 2)
  **Riesgo:** Introduce subjetividad que puede priorizar erróneamente 
  y dejar riesgos reales fuera del Top 3.

- D3 (Severidad: Menor): Entorno 24/7 requerido sin definir 
  responsable de su mantenimiento.
  **Sección:** Sección 2
  **Riesgo:** Una caída del entorno bloquea las ejecuciones frecuentes 
  que son la base del modelo de la Fase 4.

- D4 (Severidad: Menor): Escenarios con criterios cualitativos sin 
  plazo de estabilización hacia métrica automatizable.
  **Sección:** Sección 4 (Fase 1)
  **Riesgo:** Esos escenarios pueden quedar fuera de control 
  automatizado de forma indefinida.

- D5 (Severidad: Crítica): Gestión deficiente de fallos (Flakiness). **Sección:** Sección 6
**Riesgo:** Reejecutar el pipeline ante fallos oculta defectos reales en lugar de investigar la causa raíz.

---

## Slide 4 — Cobertura explícita vs vacíos

### A) Lo que la propuesta sí define
- Fases semanales con hitos específicos para 6 semanas. **Ref:** Sección 4 y 8
- Composición del Quality Gate (4 tipos de checks). **Ref:** Sección 5
- Frecuencia de revisión y gobernanza (quincenal). **Ref:** Secciones 6 y 7
- Metodología de diseño de pruebas mediante EQ/BV y Pairwise.  **Ref:** Sección 4

### B) Vacíos

- Vacío 1: Stack tecnológico y herramientas.
  **Qué falta:** No se mencionan frameworks de automatización ni motor CI/CD.
  **Por qué importa:** Imposible evaluar compatibilidad con 
  infraestructura actual del equipo.

- Vacío 2: Responsable del entorno de pruebas 24/7.
  **Qué falta:** Quién levanta, limpia y mantiene los datos del entorno.
  **Por qué importa:** Es una dependencia crítica que, de fallar, 
  anula la capacidad de ejecutar pipelines frecuentemente.

- Vacío 3: Proceso de investigación de causa raíz de fallos esporádicos.
  **Qué falta:** Quién investiga los fallos puenteados por el segundo 
  run exitoso y en qué plazo.
  **Por qué importa:** Sin responsable, la deuda técnica de pruebas 
  inestables se acumula indefinidamente.

- Vacío 4: Criterio de estabilización de métricas cualitativas.
  **Qué falta:** Cuándo y quién aprueba que un criterio cualitativo 
  se convierte en métrica automatizable.
  **Por qué importa:** Sin esto, parte del alcance queda fuera de 
  control automatizado sin fecha de resolución.

- Vacío 5: Gestión de planificación.
  **Qué falta:** Granularidad de los costos por implementación/objetivos.
  **Por qué importa:** Permite cuantificar la importancia de cada elemento de la propuesta para tomar decisiones de negocio.

- Vacío 6: Definición de alcance 
  **Qué falta:** Declaración explicita del alcance, cuantos elementos del sistema, solo apis, solo flujos críticos.
  **Por qué importa:** Permite entender a detalle la propuesta y mejor evaluación para su implementación y limitantes.

### C) Preguntas de aclaración
- P1: ¿Qué stack de herramientas proponen para automatización e integración continua?
- P2: ¿Cómo garantizan que los fallos esporádicos ignorados en primera 
  instancia sean investigados y no se conviertan en deuda técnica permanente?
- P3: ¿Qué ocurre si el equipo no logra consenso para estimar la 
  probabilidad de un riesgo en la Fase 2?

---

## Slide 5 — Goodhart / Gaming

- Señal: "reejecutar el pipeline una vez... considerar el segundo 
  resultado como referencia... con el objetivo de no detener el flujo."
  **Referencia:** Sección 6
- Riesgo de gaming: El equipo reejecutará pipelines fallidos hasta 
  que pasen en lugar de investigar o reparar el código o la prueba.
- Consecuencia probable: El Quality Gate perderá su función de barrera, 
  permitiendo el paso de defectos intermitentes y condiciones de carrera.
- Mitigación/condición: Prohibir la aceptación automática del segundo 
  run; los tests inestables deben aislarse en cuarentena (check 
  informativo) hasta ser reparados formalmente.

---

## Slide 6 — Condiciones para aceptar

- C1: Modificar formalmente la política de manejo de fallos intermitentes.
  **Cómo se verifica:** Eliminar de la propuesta la regla que acepta 
  el segundo intento como válido; reemplazarla por política de 
  cuarentena del test inestable.
  **Motivo:** D1 / Slide 5 Gaming.

- C2: Entregar anexo técnico con herramientas y matriz de responsabilidades.
  **Cómo se verifica:** Documento que detalle framework a usar y 
  responsable del entorno 24/7 antes del inicio de la Fase 1.
  **Motivo:** Vacío 1 / Vacío 2.

- C3: Incorporar heurísticas o parámetros mínimos para estimar riesgos.
  **Cómo se verifica:** Inclusión de guías (volumen de usuarios, 
  transaccionalidad, historial de incidentes) para reducir dependencia 
  del consenso subjetivo.
  **Motivo:** D2.

- C4: Definir plazo y criterio de aprobación para estabilizar métricas 
  cualitativas.
  **Cómo se verifica:** Acuerdo registrado en el repositorio al cierre 
  de la Fase 1 (semana 1).
  **Motivo:** D4 / Vacío 4.

- C5: Definición explicita del acance.   
  **Cómo se verifica:** Clarificación del alcance de la propuesta, si es por APIS, si es por sistema, si es por flujos críticos.
  **Motivo:** D6 / Vacío 6.

- C6: Explicación y granularidad de los costos.   
  **Cómo se verifica:** Clarificación de los costos y sus elementos para poder cuantificar la importancia/aceptación de cada uno.
  **Motivo:** D5 / Vacío 5.

---

## Slide 7 — Veredicto

- Decisión: **Rechazar**
- Justificación:
  1. El diseño formal de pruebas (Fase 3) y la maduración controlada 
     del CI (Fase 4) son metodológicamente sólidos y diferenciales. 
     (Fortalezas F2/F3)
  2. La cláusula de reejecución de pipelines para evitar bloqueos 
     representa un riesgo inaceptable para la integridad del gate 
     y debe modificarse estructuralmente. (D1)
  3. Ambigüedad sobre el alcance de la propuesta y la cuantificación de los elementos, esto impide comprometer el presupuesto sin garantías de comprensión total de la propuesta. (Vacíos 5 y 6)
  4. La ambigüedad sobre herramientas, responsabilidades del entorno 
     y proceso de causa raíz impide comprometer el presupuesto 
     sin garantías operacionales básicas. (Vacíos 1, 2 y 3)