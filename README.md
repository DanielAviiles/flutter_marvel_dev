# flutter_marvel_dev

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

## Commands to functional project
flutter clean
flutter pub get
flutter pub run  build_runner build --delete-conflicting-outputs

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

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
