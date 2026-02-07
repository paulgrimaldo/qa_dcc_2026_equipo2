# Casos de prueba sistemáticos — Semana 4

**Técnica usada:** Equivalencia (EQ) + Valores Límite (BV)

**Parámetro:** `{id}` en `GET /api/vets/{id}`.

## Particiones (EQ) sobre `{id}`
- **P1 - No numérico:** [`abc`, `1.5`]
- **P2 Numérico ≤ 0:** [`0`, `-1`]
- **P3 Numérico:** [`1`, `2`, `999999`, `Integer.Max=2147483647`]

## Valores límite (BV) sobre `{id}`
- Cercanos a 0: `-1`, `0`, `1`
- ID grande: `999999`
- Máximo valor posible: `Integer.Max=21474836472147483647`


## Evidencia
Cada ejecución genera:
- `evidence/week4/<TC_ID>_response.json`
- `evidence/week4/results.csv`
- `evidence/week4/resumen.txt`

## Casos de prueba

| TC-ID |        `{id}` | Partición        | Oráculos evaluados                                    | Evidencia Esperada             |
| ----- | ------------: | ---------------- | ----------------------------------------------------- | ----------------               |
| TC01  |         `abc` | P1 (No numérico) | OR1, OR2, OR3, OR4, OR5                               | `test_case_01_response.json`   |
| TC02  |         `1.5` | P1 (No numérico) | OR1, OR2, OR3, OR4, OR5                               | `test_case_02_response.json`   |
| TC03  |          `-1` | P2 (≤0, BV)      | OR1, OR2, OR3, OR4, OR5                               | `test_case_03_response.json`   |
| TC04  |           `0` | P2 (≤0, BV)      | OR1, OR2, OR3, OR4, OR5                               | `test_case_04_response.json`   |
| TC05  |           `1` | P3 (>0, BV)      | OR1, OR2, OR3, OR4, OR6, OR7, OR8, OR9                | `test_case_05_response.json`   |
| TC06  |           `2` | P3 (>0)          | OR1, OR2, OR3, OR4, OR6, OR7, OR8, OR9                | `test_case_06_response.json`   |
| TC07  |      `999999` | P3 (>0, BV)      | OR1, OR2, OR3, OR4, OR6, OR7, OR8, OR9                | `test_case_07_response.json`   |
| TC08  |  `2147483647` | P3 (>0, BV)      | OR1, OR2, OR3, OR4, OR6, OR7, OR8, OR9                | `test_case_08_response.json`   |
| TC09  |        `0001` | P3 (>0, formato) | OR1, OR2, OR3, OR4, OR6, OR7, OR8, OR9                | `test_case_09_response.json`   |
| TC10  |          `01` | P3 (>0, formato) | OR1, OR2, OR3, OR4, OR6, OR7, OR8, OR9                | `test_case_10_response.json`   |
| TC11  | `-2147483648` | P2 (≤0, BV)      | OR1, OR2, OR3, OR4, OR5                               | `test_case_11_response.json`   |
| TC12  |   `999999999` | P3 (>0)          | OR1, OR2, OR3, OR4, OR6, OR7, OR8, OR9                | `test_case_12_response.json`   |
| TC13  |       `" 1 "` | P1 (formato / espacios)  | OR1, OR2, OR3, OR4, OR5                       | `test_case_13_response.json`   |
| TC14  |          `+1` | P3 (>0, signo explícito) | OR1, OR2, OR3, OR4, OR6, OR7, OR8, OR9        | `test_case_14_response.json`   |
| TC15  |`9223372036852`| P1 (overflow numérico)   | OR1, OR2, OR3, OR4, OR5                       | `test_case_15_response.json`   |
| TC16  |         `%31` | P1 (URL-encoded)         | OR1, OR2, OR3, OR4, OR5                       | `test_case_16_response.json`   |
| TC17  | `ID_EXISTENTE`| P3 (>0, determinístico)  | OR1, OR2, OR3, OR4, OR6, OR7, OR8, OR9        | `test_case_17_response.json`   |
| TC18  |`ID_INEXISTENTE`| P3 (>0, determinístico) | OR1, OR2, OR3, OR4, OR6                       | `test_case_18_response.json`   |
| TC19  |`<ID_EXISTENTE>`(x5)| P3 (>0, idempotencia)| OR1, OR2, OR3, OR4, OR6, OR7, OR8, OR9       | `test_case_19_response.json`   |

Nota:

`OR7, OR8, OR9:`

- Solo se ejecutan si http_code == 200
- Se reportan como STRICT_PASS / STRICT_FAIL / NOT_EVALUATED
- No afectan el resultado mínimo del test