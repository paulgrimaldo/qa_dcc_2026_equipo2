# Acuerdos del Equipo

## Objetivos del Proyecto

- Proveer una aplicación de ejemplo (demo) de backend para una clínica veterinaria usando el stack moderno de Spring Boot que expone una API REST completa para operaciones típicas de gestión
- Exponer recursos CRUD (RESTful) para entidades clave del dominio Petclinic sin UI:
    - Propietarios (owners)
    - Mascotas (pets)
    - Veterinarios (vets)
    - Visitas (visits)
    - Tipos de mascota (pet types)
    - Especialidades (specialties)

Esto incluye rutas GET, POST, PUT y DELETE según entidades.
- Servir como backend desacoplado para clientes frontend (por ejemplo, spring-petclinic-angular, React u otros), enseñando cómo diseñar APIs que puedan ser consumidas por distintos clientes.
- Documentar la API con OpenAPI/Swagger para facilitar comprensión y pruebas sin UI:
    - Documentación disponible en **/swagger-ui.html**
    - Especificación OpenAPI en **/v3/api-docs**
- Proveer facilidades para pruebas y despliegue mediante scripts Postman/Newman, Docker, health checks con Spring Boot Actuator, mostrando prácticas estándar de integración y despliegue del backend


## Directrices de Comunicación

- Reuniones de coordinación: [Jueves 8:00 PM]
- Retrospectivas semanales:  [Domingo 7:00 PM]
- Estándares de documentación: [Mediante Swagger documentando todas las operaciones REST, parametros en URL, Bodys de request, para se expuestos mediante OpenAPI]

## Estándares de Calidad

- Se utilizará la ISO 25010 como linea base para determinar algunos aspectos   
   Adecuación funcional     (la Api debe cumplir operaciones CRUD basicas )
   Eficiencia en Desempeño  (Respuesta y uso de recursos)
   Usabilidad               (Desde la perspectiva del desarrollador apoyado con SWAGGER)
   Seguridad                (aspectos de seguridad autenticacion a las solicitudes) 
   Mantenibilidad           (despliegue correcto en el contenedor)       
   - Todo el código debe ser revisado por al menos un miembro del equipo
- Las pruebas deben tener mínimo 80% de cobertura
- La documentación debe actualizarse con cada cambio
- Todas las funcionalidades de calculo numerico deberan tener testCAse unitarios que validen su correcto funcionamiento

## Fechas Límite y Hitos

- Semana 1-2: Configuración y escenarios iniciales
- Semana 3-4: Diseño e implementación de casos de prueba
- Semana 5-6: Ejecución y recolección de evidencias
- Semana 7-8: Análisis y reporte final

## Resolución de Conflictos

- Comunicación directa con los miembros del equipo en las reuniones, se expone el punto y uno de los miembros del grupo actúa de mediador para poder concretar una solución.
- Los desacuerdos se abordarán mediante comunicación directa y respetuosa durante las reuniones del equipo.
- Cada parte expondrá su posición de manera argumentada.
- Uno de los integrantes actuará como mediador, con el objetivo de facilitar una solución consensuada y alineada a los objetivos académicos y de calidad del proyecto.