# QA Doctorado 2026 - Equipo 2

## Descripción del Proyecto
Este repositorio contiene los artefactos técnicos, código y documentación asociados al proyecto QA Doctorado 2026, desarrollado por el Equipo 2.
El proyecto implementa un servicio backend REST para la gestión de una clínica veterinaria utilizando el framework Spring Boot. El servicio expone recursos CRUD (Create, Read, Update, Delete) para las entidades principales del dominio, siguiendo un estilo de arquitectura orientada a servicios.
El sistema actúa como System Under Test (SUT) para la aplicación de técnicas, métricas y métodos de Aseguramiento de la Calidad (QA) en un contexto académico.
Además, este repositorio se utiliza como base para la ejecución de pruebas, generación de métricas y documentación de resultados del proceso de QA durante el curso.

## Estructura del Repositorio
- setup/ – Scripts para configurar el entorno de desarrollo y ejecución.
- scripts/ - Scripts de pruebas y mediciones
- evidence/ - Recolección de evidencias semanales
- quality/ - Escenarios de calidad y glosario
- riesgos/ - Evaluación de riesgos y estrategia de pruebas
- memos/ – Memorandos semanales de progreso técnico y decisiones de QA.
- slides/ - Materiales de presentación
- AGREEMENTS.md – Acuerdos de trabajo, responsabilidades y estándares.
- Makefile – Automatización de tareas de construcción y ejecución.
- README.md – Este documento principal.
- SUT_SELECTION.md – Documento de selección y descripción del System Under Test (backend).


## Primeros Pasos

Revisar los acuerdos de equipo. [Agreements](./AGREEMENTS.md)

## Instalación docker

Requiere un entorno con docker instalado. [Instalación](https://docs.docker.com/engine/install)

### Instrucciones de ejecución del proyecto

Ejecute `make` para ver la lista de commandos disponibles.

Si su entorno (SO), no cuenta con con `make` entonces revise y ejecute los scripts de configuración en `setup/`, en el orden conveniente.


## Miembros del Equipo

- Mercado Hidalgo Luis Angel
- Espinoza Orosco Ruben
- Leaños Rodriguez Alcides Yohacin
- Soto Roca Ernesto 
- Grimaldo Bravo Paul Fernando
