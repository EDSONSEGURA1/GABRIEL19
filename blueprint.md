# Blueprint de la Aplicación de Inventarios UNAP

## 1. Descripción General

Esta aplicación de Flutter está diseñada para la gestión de inventarios de la UNAP. Permite a los usuarios realizar un seguimiento de los equipos, ver sus detalles y gestionar su mantenimiento. La aplicación cuenta con un diseño moderno y profesional, con soporte para temas claro y oscuro, y una interfaz de usuario intuitiva construida con Material Design 3.

## 2. Estructura del Proyecto y Diseño

La aplicación sigue una arquitectura limpia y organizada para facilitar su mantenimiento y escalabilidad.

### Archivos y Carpetas Clave:

-   `lib/main.dart`: Es el punto de entrada de la aplicación. Configura la inicialización de Firebase, el proveedor de temas (`ThemeProvider`) y la estructura principal de la aplicación con `MaterialApp.router`.

-   `lib/router/router.dart`: Define toda la navegación de la aplicación utilizando el paquete `go_router`. Gestiona las rutas a las diferentes pantallas, como la pantalla de inicio, la de equipos, la de autenticación, etc.

-   `lib/screens/`: Esta carpeta contiene todas las pantallas principales de la aplicación.
    -   `home_screen.dart`: La nueva pantalla de bienvenida. Sirve como punto de partida visual y funcional, con acceso a la pantalla de equipos.
    -   `equipos_screen.dart`: La pantalla principal para ver la lista de equipos.
    -   `auth_screen.dart`: Pantalla para la autenticación de usuarios.
    -   `equipo_form_screen.dart`: Formulario para crear o editar un equipo.
    -   `mantenimiento_screen.dart`: Pantalla para gestionar el mantenimiento de un equipo.
    -   `perfil_screen.dart`: Pantalla para ver el perfil del usuario.

-   `pubspec.yaml`: Define las dependencias del proyecto, como `flutter_riverpod` para el estado, `go_router` para la navegación, `google_fonts` para la tipografía y los paquetes de Firebase.

### Diseño y Estilo (Theming):

El sistema de temas está centralizado en `lib/main.dart` para garantizar una apariencia consistente en toda la aplicación.

-   **Proveedor de Tema (`ThemeProvider`):** Una clase que utiliza `ChangeNotifier` para gestionar el estado del tema (claro, oscuro o sistema) y notifica a la interfaz de usuario cuando hay un cambio.

-   **Material Design 3:** La aplicación utiliza `useMaterial3: true` para adoptar las últimas directrices de diseño de Google, lo que le da un aspecto moderno.

-   **Esquema de Colores:**
    -   Se utiliza `ColorScheme.fromSeed` con un color base (`Colors.deepPurple`) para generar paletas de colores armoniosas y accesibles tanto para el modo claro como para el oscuro.

-   **Tipografía (`google_fonts`):
    -   **Oswald:** Se usa para los títulos principales (`displayLarge`) y los títulos de la barra de aplicaciones, dándole un aspecto fuerte y moderno.
    -   **Roboto:** Se usa para los títulos secundarios y el texto del cuerpo, garantizando una excelente legibilidad.
    -   **Open Sans:** Se usa para el texto del cuerpo más pequeño.

-   **Componentes Personalizados:** Se han definido estilos específicos para `AppBar` y `ElevatedButton` para que coincidan con la paleta de colores y el diseño general.

## 3. Características Implementadas

### Funcionalidad Central:

-   **Gestión de Tema Profesional:**
    -   **Alternancia de Tema:** Los usuarios pueden cambiar manualmente entre el modo claro y oscuro.
    -   **Tema del Sistema:** La aplicación puede adaptarse automáticamente a la configuración del tema del sistema operativo del dispositivo.
    -   **Persistencia Visual:** El tema se aplica de manera consistente en todas las pantallas.

-   **Pantalla de Inicio Moderna (`HomeScreen`):
    -   **Diseño Atractivo:** Incluye un fondo con gradiente sutil y texto bien jerarquizado para una primera impresión profesional.
    -   **Navegación Intuitiva:** El botón "Empezar" dirige a los usuarios a la funcionalidad principal de la aplicación (la pantalla de equipos).

-   **Navegación Robusta con `go_router`:**
    -   Las rutas están claramente definidas, permitiendo una navegación fluida y la posibilidad de añadir fácilmente nuevas pantallas en el futuro.

### Próximos Pasos (Plan Actual):

Actualmente, la aplicación está en un estado estable y lista para ser presentada. El siguiente paso en el plan es conectar completamente la funcionalidad del backend de Firebase con todas las pantallas para:

-   Gestionar la autenticación de usuarios.
-   Leer y escribir datos de equipos en Firestore.
-   Almacenar y recuperar imágenes de equipos desde Firebase Storage.
