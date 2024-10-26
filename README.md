# Rick and Morty App 📱
[![Coverage - 100%](https://img.shields.io/badge/Coverage-1000%25-2ea44f)](https://) [![Flutter - 3.24.4](https://img.shields.io/badge/Flutter-3.24.4-2596be)](https://)



## 📋 Índice

- [Resumen del Proyecto](#-resumen-del-proyecto)
- [Arquitectura](#️-arquitectura)
- [Dependencias Principales](#️-dependencias-principales)
- [Configuración y Ejecución](#-configuración-y-ejecución)
- [Testing](#-testing)

## 📝 Resumen del Proyecto

Rick and Morty App es una aplicación Flutter diseñada para explorar información sobre los personajes de la serie "Rick and Morty". Ofrece las siguientes funcionalidades:

- 📋 Visualizar una lista de personajes con paginación infinita
- 🔍 Buscar personajes por nombre
- 👤 Ver detalles de cada personaje
- 🔐 Autenticación de usuarios mediante Firebase

La aplicación utiliza la API pública de Rick and Morty para obtener los datos de los personajes y Firebase para la autenticación de usuarios.

## 🏗️ Arquitectura

El proyecto implementa Clean Architecture con el patrón Provider para la gestión del estado. La estructura está organizada por features y capas:

```
lib/
├── app/
│   ├── app.dart
│   ├── colors.dart
│   └── theme.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── characters/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── features/
    └── shared/
        └── presentation/
            └── widgets/
```

### Capas de la Arquitectura:

- **Presentación**: Contiene las pantallas, widgets y providers.
- **Dominio**: Define entidades y contratos de repositorios.
- **Datos**: Implementa repositorios y maneja fuentes de datos.

## 🛠️ Dependencias Principales

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_auth: ^4.15.3
  firebase_core: ^2.24.2
  http: ^1.1.0
  provider: ^6.1.1
  cached_network_image: ^3.3.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  mocktail: ^1.0.0
```

## 🚀 Configuración y Ejecución

0. **Requisitos Previos**
   - Flutter versión 3.24.4

1. **Clonar el Repositorio**
   ```bash
   git clone https://github.com/cjamcu/rickandmorty
   cd rickandmorty
   ```

2. **Instalar Dependencias**
   ```bash
   flutter pub get
   ```

3. **Ejecutar la Aplicación**
   ```bash
   flutter run
   ```

## 🧪 Testing

La estrategia de testing cubre diferentes componentes de la aplicación:

```
test/
└── features/
    ├── auth/
    │   ├── data/
    │   │   ├── datasources/
    │   │   └── repositories/
    │   └── presentation/
    │       └── providers/
    └── characters/
        ├── data/
        │   ├── datasources/
        │   └── repositories/
        └── domain/
            └── entities/
```

### Componentes Probados

- **Auth**: Pruebas para el datasource de Firebase Auth y el repositorio de autenticación.
- **Characters**: Pruebas para el datasource de la API de Rick and Morty, el repositorio de personajes y las entidades.

### Ejecutar Tests

```bash
flutter test
```

Para ver un informe detallado de la cobertura de pruebas, puedes ejecutar:

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

Esto generará un informe HTML que puedes ver en tu navegador abriendo el archivo `coverage/html/index.html`.
