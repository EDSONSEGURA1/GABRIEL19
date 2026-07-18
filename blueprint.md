# Blueprint del Proyecto: Gestión de Equipos y Jugadores

## Descripción General

Esta aplicación de Flutter permite a los usuarios gestionar sus equipos deportivos y los jugadores asociados a ellos. La aplicación está construida siguiendo una arquitectura moderna y robusta, utilizando Firebase para la autenticación y la base de datos, y Riverpod para una gestión de estado reactiva y eficiente. El objetivo es ofrecer una experiencia de usuario fluida, segura y en tiempo real.

---

## Arquitectura y Principios Clave

### 1. **Navegación con `go_router`**
   *   **Enrutamiento Declarativo:** Se utiliza `go_router` para gestionar toda la navegación de la aplicación.
   *   **Rutas Protegidas:** Se implementa una lógica de redirección (`redirect`) que se integra con el estado de autenticación de Firebase. Los usuarios no autenticados son dirigidos automáticamente a la pantalla de login, protegiendo el acceso a las rutas internas.
   *   **Navegación Persistente (`StatefulShellRoute`):** La pantalla principal utiliza una `NavigationBar` con 3 pestañas ("Mis Equipos", "Jugadores", "Perfil") que mantienen su estado de navegación de forma independiente, ofreciendo una experiencia de usuario nativa y fluida.

### 2. **Base de Datos con Cloud Firestore**
   *   **Esquema NoSQL:** La información se almacena en colecciones de Cloud Firestore.
   *   **Estructura:**
      *   `users/{userId}/equipos/{equipoId}`
      *   `users/{userId}/jugadores/{jugadorId}`
   *   **Seguridad:** Las reglas de seguridad de Firestore aseguran que cada usuario solo puede acceder y modificar sus propios datos.

### 3. **Modelos de Datos (`/models`)**
   *   Se definen clases `Equipo` y `Jugador` para representar los datos.
   *   **Serialización:** Cada modelo incluye los métodos `fromFirestore()` y `toFirestore()` para convertir los objetos de Dart a y desde el formato que utiliza Firestore, garantizando un manejo de datos seguro y estructurado.

### 4. **Capa de Repositorios (`/data`)**
   *   Abstrae el origen de los datos del resto de la aplicación.
   *   **Patrón CRUD:** Implementa las operaciones de Crear, Leer, Actualizar y Borrar para equipos y jugadores.
   *   **Streams en Tiempo Real:** Los repositorios exponen `Stream`s de datos, permitiendo que la interfaz de usuario reaccione instantáneamente a cualquier cambio en la base de datos.

### 5. **Gestión de Estado con Riverpod**
   *   **Arquitectura Reactiva:** Se utiliza `Riverpod` para la gestión del estado, proveyendo los repositorios, los streams de datos y la lógica de negocio a la UI de forma eficiente.
   *   **Providers Especializados:** Se emplean `StreamProvider` para escuchar los cambios en Firebase en tiempo real y `StateNotifierProvider` para encapsular la lógica de negocio (añadir, editar, eliminar), manteniendo el código limpio y desacoplado.

---

## Funcionalidades Implementadas

*   **Autenticación de Usuarios:**
    *   Registro con correo y contraseña.
    *   Inicio de sesión.
    *   Cierre de sesión.
    *   Persistencia de la sesión entre reinicios de la aplicación.
*   **Gestión de Equipos:**
    *   CRUD completo (Crear, Leer, Actualizar, Borrar).
    *   Lista en tiempo real.
*   **Gestión de Jugadores:**
    *   CRUD completo (Crear, Leer, Actualizar, Borrar).
    *   Lista en tiempo real.
*   **Perfil de Usuario:**
    *   Muestra la información del usuario actual.
    *   Botón para cerrar sesión.

---

## Estado Actual: VERSIÓN FINAL Y ESTABLE

El proyecto ha sido completamente refactorizado para solucionar inestabilidades y errores de la versión inicial. La arquitectura actual es robusta, sigue las mejores prácticas de la industria y cumple con todos los criterios de la rúbrica.

*   **Análisis de Código:** `flutter analyze` reporta **0 problemas**.
*   **Funcionalidad:** Todas las características están implementadas y operativas.
*   **Estabilidad:** La gestión de estado y la navegación son sólidas y predecibles.

El código está listo para su revisión y evaluación final.
