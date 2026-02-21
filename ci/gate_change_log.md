# Gate Change Log

Registro breve y auditable de cambios del Quality Gate y su gobernanza.

## 2026-02-21 — Semana 6: Integridad del gate
- Cambio: se agrega verificación de integridad (`ci/verify_gate_integrity.sh`) basada en hashes (`ci/gate_integrity_baseline.txt`).
- Se agrega verificación de contenido (`post_gate_verify_content.sh`) basada en casos esperados
- Motivo: mitigar *gaming* por modificación silenciosa scripts y manipulación de evidencia.
- Impacto esperado: el gate falla si se alteran artefactos protegidos sin actualizar baseline y registrar el cambio.
- Evidencia: `evidence/week6/after/` donde se encuentra el intento de bypass.