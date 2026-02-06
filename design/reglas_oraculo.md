# Reglas de Oráculo — Semana 4

**Objeto de prueba:** `GET /api/vets/{id}`

## Reglas mínimas

- **OR1 (Ejecución):** Todas las solicitudes registran `http_code` y persisten el cuerpo de la respuesta como evidencia.
- **OR2 (Cuerpo de la respuesta):** La respuesta **no** debe ser HTML (Verificación mediante `header` valor de `Content-Type=application/json` )
- **OR3 (Formato de errores):** La respuesta debe retornar  `http_code=404` Ante ausencia de valores y `http_code=500` ante cualquier otro escenario de error.
- **OR4 (JSON Valido cuando no hay errores de tipo 500)** Si `http_code!=500` Entonces el `header Content-Type` siempre sera `application/json`

## Reglas por partición

- **OR5 (ID inválido no aceptado):** Si `{id}` especificado en el `path` es un valor literal **no-numerico** o es un valor numerico pero **≤0** entonces la respuesta debe ser `http_code != 200`
- **OR6 (ID numérico válido):** Si`{id}` especificado en el `path` es numérico y es **> 0**, entonces `http_code` debe estar en `{200, 404}`.

## Reglas estrictas

- **OR7 (Cupero de la respuesta no vacio en `http_code=200`):** Si `http_code == 200` para el `{id}` numérico válido, el cuerpo no debería ser un JSON vacío `{}`.
- **OR8 (Consistencia semántica en `http_code=200`):** Si `http_code == 200` para el `{id}` numérico válido, el cuerpo debería incluir un campo `"id"` (idealmente con el mismo valor).  
- **OR9 (Idenpotencia en input/output):** Si se realizan ejecuciones secuenciales (Por ejemplo 5 ejecuciones con el mismo `{id}` todas las respuestas apuntan al mismo output). 