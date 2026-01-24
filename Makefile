# Makefile para el Proyecto QA Doctorado

.PHONY: help setup start-petclinic-rest stop-petclinic-rest healthcheck smoke Q1-CapturarContratoApi Q2-Latencia Q3-ValidarInputs Q4-Vets QA-week2 clean

# Objetivo por defecto
help:
	@echo "Objetivos disponibles:"
	@echo ""
	@echo "Configuración:"
	@echo "  setup          - Configurar el entorno"
	@echo "  start-petclinic-rest - Iniciar la aplicación Pet Clinic REST"
	@echo "  stop-petclinic-rest  - Detener la aplicación Pet Clinic REST"
	@echo "  healthcheck    - Verificar la salud del sistema"
	@echo ""
	@echo "Escenarios de Calidad - Semana 2:"
	@echo "  Q1-CapturarContratoApi   - Escenario Q1: Disponibilidad mínima de Contrato OpenAPI de Pet Clinic REST"
	@echo "  Q2-Latencia              - Escenario Q2: Latencia básica del endpoint de Veterinarios y Servicios"
	@echo "  Q3-ValidarInputs  - Escenario Q3: Robustez ante IDs inválidos"
	@echo "  Q4-Vets       - Escenario Q4: Respuesta bien formada en endpoint de Veterinarios y Servicios"
	@echo "  QA-week2           - Ejecutar todos los escenarios Q1-Q4 de la semana 2"
	@echo ""
	@echo "Pruebas Legacy:"
	@echo "  smoke          - Ejecutar pruebas de humo"
	@echo ""
	@echo "Utilidades:"
	@echo "  clean          - Limpiar archivos temporales"

setup:
	@echo "Configurando entorno..."
	chmod +x setup/*.sh scripts/*.sh
	./setup/run_sut.sh

start-petclinic-rest:
	./setup/run_sut.sh

stop-petclinic-rest:
	./setup/stop_sut.sh

healthcheck:
	./setup/healthcheck_sut.sh

smoke:
	./scripts/smoke.sh

Q1-CapturarContratoApi:
	./scripts/capturarContratoApi.sh

Q2-Latencia:
	./scripts/revisarLatencia.sh

Q3-ValidarInputs:
	./scripts/validarInputs.sh

Q4-Vets:
	./scripts/capturarVet.sh

QA-week2: Q1-CapturarContratoApi Q2-Latencia Q3-ValidarInputs Q4-Vets
	@echo ""
	@echo "================================"
	@echo "✅ Todos los escenarios Q1-Q4 completados"
	@echo "================================"

clean:
	rm -rf tmp/
	rm -f *.log
	./setup/stop_sut.sh