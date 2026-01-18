# Makefile para el Proyecto QA Doctorado

.PHONY: help setup start-petclinic-rest stop-petclinic-rest healthcheck smoke Q1-contract Q2-latency Q3-invalid-inputs Q4-inventory QA-week2 clean

# Objetivo por defecto
help:
	@echo "Objetivos disponibles:"
	@echo ""
	@echo "Configuración:"
	@echo "  setup          - Configurar el entorno"
	@echo "  start-petclinic-rest - Iniciar la aplicación Pet Clinic REST"
	@echo "  stop-petclinic-rest  - Detener la aplicación Pet Clinic REST"
	@echo "  healthcheck    - Verificar la salud del sistema"
	@echo "Utilidades:"
	@echo "  clean          - Limpiar archivos temporales"

setup:
	@echo "Configurando entorno..."
	chmod +x setup/*.sh
	./setup/run_sut.sh

start-petclinic-rest:
	./setup/run_sut.sh

stop-petclinic-rest:
	./setup/stop_sut.sh

healthcheck:
	./setup/healthcheck_sut.sh

clean:
	rm -rf tmp/
	rm -f *.log
	./setup/stop_sut.sh