# Memo de Progreso — Semana 6
Fecha: 19/02/2026  
Equipo: Equipo 2  
Semana: 6 de 8  

## Objetivos de la semana
- Ejecutar un gaming drill sobre el quality gate definido en Semana 5.
- Aplicar una táctica de gaming realista y generar evidencia reproducible (before).
- Implementar una defensa técnica mínima contra esa táctica.
- Ejecutar el experimento after verificando que la defensa detiene el gaming.
- Integrar el drill en un script ejecutable y un target de Makefile.

## Logros
- **Gaming identificado:** reducción silenciosa del conjunto de casos sistemáticos, afectando el check de “Casos sistemáticos deben ejecutarse y cualquier FAIL requiere acción”.
- **Evidencia before/after:** evidencia reproducible generada en `evidence/week6/before/` y `evidence/week6/after/`, incluyendo RUNLOG y artefactos comparables.
- **Defensa aplicada:** verificación obligatoria de integridad del set de casos (conteo + hash), bloqueando el gate si la evidencia no coincide con los 19 casos definidos.
- **Lección aprendida:** sin contratos mínimos verificables, el gate es vulnerable a manipulación; invariantes simples (conteo, hashes, artefactos obligatorios) reducen significativamente oportunidades de gaming.

## Trabajo realizado

### 1. Preparación
- Creación de la rama `week6`.
- Creación de estructura:

### 2. Táctica de gaming seleccionada
**Táctica:** ejecutar solo una parte de los casos sistemáticos sin declararlo.  
**Check afectado:** validación del conjunto sistemático de Semana 4.  
**Justificación:** el gate asumía de forma implícita la existencia del set completo; al ejecutar menos casos, el summary aparenta éxito sin mejorar calidad.  
Documentado en `ci/gaming_drill.md`.

### 3. Experimento BEFORE (sin defensa)
- Carpeta creada: `evidence/week6/before/`.
- Se modificó temporalmente el gate ejecutando solo 5 de 19 casos.
- Ejecución con:

- El gate marcó PASS debido a evidencia incompleta pero consistente con la manipulación.
- En `evidence/week6/RUNLOG.md` se registró:
- Comando exacto
- Fecha/hora
- Qué se alteró para “pasar”
- La evidencia es completamente verificable mediante artefactos y comandos.

### 4. Defensa técnica aplicada
**Defensa:** agregar un módulo de integridad que valide:
1. Conteo exacto: deben existir los 19 casos definidos.
2. Hash del archivo de definición de casos: comparado contra un valor almacenado.
Si alguna condición falla, el gate aborta y registra “possible gaming detected”.
Registrado en:
- `ci/gate_change_log.md` (cambio, impacto, fecha)
- `ci/gaming_drill.md` (cómo bloquea la táctica)

### 5. Experimento AFTER (con defensa)
- Carpeta creada: `evidence/week6/after/`.
- Se repitió exactamente la misma táctica del BEFORE.
- Resultado:
- El gate detectó inconsistencia y marcó FAIL explícito.
- Se generó evidencia de la detección del intento de gaming.
- Artefactos comparables con BEFORE almacenados en after/.

### 6. Script del drill
Se añadió `ci/run_gate_gaming_drill.sh` que:
- Ejecuta automáticamente el BEFORE y AFTER.
- Deposita evidencia completa en `evidence/week6/...`.
- Genera `evidence/week6/summary.txt` con un resumen comparativo.

### 7. Integración en Makefile
Se añadió el targety genera evidencia completa en `evidence/week6/`.

## Evidencia principal
| Tipo | Ubicación |
|------|-----------|
| Táctica y documentación | `ci/gaming_drill.md` |
| Registro del cambio del gate | `ci/gate_change_log.md` |
| Script del drill | `ci/run_gate_gaming_drill.sh` |
| Evidencia BEFORE | `evidence/week6/before/` |
| Evidencia AFTER | `evidence/week6/after/` |
| Resumen del drill | `evidence/week6/summary.txt` |

## Retos y notas
- El gate original no tenía invariantes que garantizaran integridad en los artefactos sistemáticos.
- La defensa introducida detecta y detiene manipulaciones sin depender de nuevas herramientas.
- BEFORE/AFTER permitió observar diferencias claras en la evidencia, fortaleciendo la auditabilidad.

## Lecciones aprendidas
- Los quality gates necesitan contratos mínimos verificables para evitar manipulaciones.
- Invariantes simples (conteo, hashes, evidencia obligatoria) son extremadamente efectivas contra gaming.
- La reproducibilidad es fundamental para auditar intentos de gaming y justificar decisiones de aceptación/rechazo.
- Ejecutar un BEFORE/AFTER controlado revela brechas reales del gate y evidencia el impacto de las defensas.

## Próximos pasos
- Extender defensas a otros checks (contrato, latencia, entradas inválidas).
- Agregar hashing a más artefactos del gate.
- Investigar más tácticas de gaming y reforzar el gate de forma incremental.
