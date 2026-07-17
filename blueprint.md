# Blueprint de la Aplicación: Gestión de Fichajes de Fútbol

## Visión General

Esta aplicación es un sistema completo para gestionar jugadores de fútbol, los clubes a los que pertenecen y el historial de fichajes entre ellos. La app está diseñada con una arquitectura limpia, una interfaz de usuario moderna basada en Material 3 y una gestión de estado reactiva.

## Arquitectura y Diseño Actual

- **Estructura de Carpetas:** Se ha adoptado un enfoque organizado por tipo de archivo, lo que ha permitido una estructura más limpia y mantenible:
  - `lib/models/`: Clases de datos (`Player`, `Club`).
  - `lib/providers/`: Gestores de estado con `ChangeNotifier` (`PlayerProvider`, `ClubProvider`).
  - `lib/screens/`: Pantallas principales y de formularios.
  - `lib/widgets/`: Widgets reutilizables (`PlayerCard`, `ClubCard`, `CustomNavigationBar`).
  - `lib/router/`: Configuración de `go_router`.
  - `lib/theme/`: Definición del tema de la aplicación.

- **Navegación:** Se utiliza `go_router` para una navegación declarativa y robusta. La navegación principal se gestiona con un `ScaffoldWithNavigationBar` que contiene un `CustomNavigationBar` personalizado.

- **Gestión de Estado:** Se ha integrado `provider` para una gestión de estado centralizada y reactiva. `PlayerProvider` y `ClubProvider` exponen los datos y la lógica de negocio a la UI.

- **UI y Diseño:**
  - **Tema:** Se ha implementado un tema moderno con Material 3, `google_fonts` y `ColorScheme.fromSeed`.
  - **Tarjetas Personalizadas:** `PlayerCard` y `ClubCard` muestran la información de forma clara y atractiva.
  - **Formularios:** Las pantallas de creación y edición (`PlayerFormScreen`, `ClubFormScreen`) están completamente funcionales.

## Funcionalidad Implementada

- **CRUD Completo para Jugadores y Clubes:**
  - **Crear:** Se pueden añadir nuevos jugadores y clubes a través de formularios dedicados.
  - **Leer:** Las listas de jugadores y clubes se muestran en sus respectivas pantallas.
  - **Actualizar:** La información existente se puede editar.
  - **Eliminar:** Se pueden borrar jugadores y clubes de la lista.
- **Navegación Intuitiva:** El usuario puede moverse fácilmente entre las secciones de jugadores y clubes.
- **Feedback al Usuario:** Se utilizan `CircularProgressIndicator` durante las cargas y se navega hacia atrás después de las operaciones de guardado/eliminación.

## Próximos Pasos

### Fase 1: Implementar la Funcionalidad de Fichajes

1.  **Modelo y Provider de Fichajes:**
    - Crear `Transfer` model (`lib/models/transfer_model.dart`).
    - Crear `TransferProvider` (`lib/providers/transfer_provider.dart`) para gestionar la lista de fichajes.
2.  **Pantalla de Fichajes:**
    - Crear `transfers_screen.dart` para mostrar la lista de fichajes.
    - Crear `TransferCard` widget (`lib/widgets/transfer_card.dart`).
3.  **Formulario de Fichajes:**
    - Crear `transfer_form_screen.dart` para crear nuevos fichajes.
    - El formulario deberá permitir seleccionar un jugador y los clubes de origen y destino de las listas existentes (usando `DropdownButtonFormField`).

### Fase 2: Conexión a la Nube con Firebase

1.  **Configuración de Firebase:** Crear un proyecto en Firebase y configurar la aplicación Flutter.
2.  **Cloud Firestore:** Migrar los datos (jugadores, clubes, fichajes) a Cloud Firestore.
3.  **Refactorizar Providers:** Adaptar los `Providers` para que lean y escriban en Firestore en lugar de en listas en memoria.

### Fase 3: Mejoras de UI/UX y Pruebas

1.  **Búsqueda y Filtros:** Implementar la funcionalidad de búsqueda y los filtros en las pantallas de jugadores y clubes.
2.  **Feedback Visual:** Añadir `SnackBar`s para confirmar acciones (ej: "Jugador guardado con éxito").
3.  **Pruebas:** Escribir `Unit Tests` y `Widget Tests` para el código nuevo.
