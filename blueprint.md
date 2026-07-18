# Blueprint de la Aplicación de Inventarios UNAP

## Visión General

Esta aplicación, desarrollada en Flutter con Firebase, está diseñada para ser un sistema de inventario robusto y escalable, enfocado inicialmente en la gestión de equipos deportivos y jugadores para la Universidad Nacional de la Amazonía Peruana (UNAP). La app permite a los usuarios autenticados gestionar (crear, leer, actualizar, eliminar) registros de manera eficiente, con una interfaz limpia, moderna y reactiva gracias a Riverpod.

---

## Diseño y Estilo

La aplicación sigue los principios de Material Design 3, asegurando una experiencia de usuario moderna e intuitiva.

*   **Paleta de Colores:** Se utiliza `ColorScheme.fromSeed` con un color primario azul (`Colors.blue`), generando un esquema de colores armonioso y profesional tanto en modo claro como oscuro.
*   **Tipografía:** Se emplea una fuente limpia y legible (la fuente por defecto de Material) con una jerarquía clara para títulos, subtítulos y cuerpo de texto.
*   **Iconografía:** Se utilizan iconos de Material Icons para acciones comunes (añadir, editar, eliminar, perfil, etc.), proporcionando una navegación visualmente intuitiva.
*   **Componentes Personalizados:**
    *   `CustomTextFormField`: Un campo de texto reutilizable con un estilo consistente.
    *   `CustomElevatedButton`: Un botón elevado personalizable para acciones principales.
*   **Diseño Responsivo:** La interfaz se adapta correctamente a diferentes tamaños de pantalla, asegurando una buena experiencia tanto en web como en móvil.

---

## Características Implementadas

### 1. Autenticación de Usuarios
*   **Flujo Completo:** Sistema de registro e inicio de sesión con correo electrónico y contraseña a través de Firebase Auth.
*   **Persistencia de Sesión:** El usuario permanece conectado hasta que explícitamente cierra sesión.
*   **Redirección Automática:** La aplicación gestiona el estado de autenticación, mostrando la pantalla de login si el usuario no está conectado y redirigiendo a la pantalla principal tras un inicio de sesión exitoso.

### 2. Navegación Principal (Shell Navigation)
*   **Navegación Persistente:** Se utiliza un `StatefulShellRoute` de `go_router` para crear una barra de navegación inferior (`BottomNavigationBar`) que no se pierde al navegar entre las secciones principales.
*   **Secciones Principales:**
    *   **Mis Equipos:** Para la gestión del inventario de equipos.
    *   **Jugadores:** Para la gestión de la plantilla de jugadores.
    *   **Perfil:** Para ver la información del usuario y cerrar sesión.
*   **Navegación Modal:** Las pantallas para añadir o editar registros se muestran como una capa por encima de la navegación principal, proporcionando una experiencia de usuario fluida.

### 3. Gestión de Equipos (CRUD Completo)
*   **Crear:** Los usuarios pueden añadir nuevos equipos a través de un formulario dedicado, especificando nombre, descripción y categoría.
*   **Leer:** Se muestra una lista en tiempo real de todos los equipos del usuario. Incluye una barra de búsqueda para filtrar equipos por nombre.
*   **Actualizar:** Se puede editar la información de un equipo existente.
*   **Eliminar:** Los equipos se pueden borrar de la base de datos, con un diálogo de confirmación para evitar acciones accidentales.
*   **Base de Datos:** Toda la información se almacena y sincroniza con Cloud Firestore.

### 4. Gestión de Jugadores (CRUD Completo)
*   **Crear:** Los usuarios pueden añadir nuevos jugadores, especificando su nombre, posición y edad.
*   **Leer:** Se muestra una lista en tiempo real de todos los jugadores registrados por el usuario.
*   **Actualizar:** Se puede editar la información de un jugador existente.
*   **Eliminar:** Los jugadores se pueden borrar de la base de datos con un diálogo de confirmación.
*   **Base de Datos:** La información se gestiona a través de Cloud Firestore en una colección separada.

### 5. Perfil de Usuario
*   **Visualización de Datos:** Muestra el correo electrónico del usuario actualmente autenticado.
*   **Cierre de Sesión:** Un botón prominente permite al usuario cerrar su sesión de forma segura, redirigiéndolo a la pantalla de autenticación.

### 6. Gestión de Estado con Riverpod
*   **Arquitectura Reactiva:** Se utiliza `Riverpod` para la gestión del estado, proveyendo los repositorios, los streams de datos y la lógica de negocio a la UI de forma eficiente.
*   **Providers Especializados:** Se emplean `StreamProvider` para escuchar los cambios en Firebase en tiempo real y `StateNotifierProvider` para encapsular la lógica de negocio (añadir, editar, eliminar), manteniendo el código limpio y desacoplado.

---

## Plan para la Implementación de "Jugadores" (Completado)

1.  **Crear el Modelo `Jugador`:** Definir la estructura de datos en `lib/models/jugador.dart`.
2.  **Crear `JugadorRepository`:** Implementar la lógica de comunicación con Firestore en `lib/data/jugador_repository.dart`.
3.  **Crear `jugador_provider.dart`:** Configurar los providers de Riverpod para gestionar el estado de los jugadores.
4.  **Diseñar `JugadorCard`:** Crear un widget reutilizable para mostrar la información de cada jugador en `lib/widgets/jugador_card.dart`.
5.  **Crear Formulario `AddEditJugadorScreen`:** Implementar la pantalla para añadir y editar jugadores.
6.  **Actualizar `JugadoresScreen`:** Reemplazar el contenido estático con la lista dinámica de jugadores.
7.  **Configurar Rutas en `go_router`:** Añadir las rutas para el formulario de añadir/editar jugadores.
8.  **Actualizar `blueprint.md`:** Documentar la nueva funcionalidad implementada.
