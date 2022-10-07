# flutter_marvel_dev

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

## Commands to functional project
Se deben correr los siguientes comandos para levantar el proyecto. Adicional
El proyecto usa una herramienta llamada fvm para el control de versiones de
flutter SDK. Por otro lado, el proyecto usa Nullsafty por lo tanto, esta
basado en flutter 3.0.0 o superior.

  * flutter clean
  * flutter pub get
  * flutter pub run  build_runner build --delete-conflicting-outputs

## Documentación de arquitectura

Primero que todo - Habrá que crear 2 archivos .env, bajo el nombre de
".env.development" y ".env.production", el contenido que debe ir en esos archivos es
el siguiente

  * PUBLIC_API_KEY=**APYKEY DE MARVEL DEVELOPER**
  * PRIVATE_API_KEY=**PRIVATE API KEY MARVEL DEVELOPER**
  * BASE_URL=http://gateway.marvel.com/v1/public

### [lib/app/core]
Principalmente la arquitectura del proyecto va a base de arquitectura hexagonal
la cual puede ser evidenciada en "[lib/app/core]" donde se puede identificar
una estructura de infrastructura que contiene entidades de "Service Client",
entidades de excepción, errores, constantes definidas para mantener control y no ambiguedad.
De igual manera, contiene un gestor de estado personalizado "GenericFieldBloc" basado en
RxDart, donde se manipula para configuracion de validaciones.

También se definen casos de uso metodos globales y widget globales

### [lib/app/data]
Para este caso en particular se define toda la capa de dominio apuntando a
implementación de repositorios locales y remotos. Además se encuentran entidades
o modelos implicados para la interpretación de datos en la capa UI

### [lib/app/di]
Para esta capa solo es la implementación de inyección de dependecias

### [lib/app/modules]
En esta capa ya está identificada la UI, donde se implementa una estructura a base de:
  * nombre del modulo
  *application donde se ejecutan querys de modificación y consulta
  *domain donde se encuentra la abstración de repositorios y modelos que se implementará en casos de uso
  *ui donde estará representa la vista

### [lib/app/routes]
Para este nivel de carpeta en el proyecto, solo está identificada y definida la proyección de
rutas de uso a la aplicación

## Nota
Por falta de tiempo y percances, no se logró realizar implementación de HIVE como NoSQL
para persistencia de datos, y tampoco se realizó unit test con Mockito, que era lo ideal
para la construcción de este proyecto.
