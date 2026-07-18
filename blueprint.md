# Blueprint: Inventarios UNAP

## Visión General

Esta aplicación está diseñada para gestionar el inventario de equipos de la UNAP. Permite a los usuarios autenticados rastrear equipos, ver su estado, registrar mantenimientos y buscar en su inventario.

## Estilo y Diseño

La aplicación sigue los principios de Material Design 3, utilizando un esquema de color moderno, tipografía legible con `google_fonts`, y componentes interactivos y bien espaciados para una experiencia de usuario intuitiva. Se presta especial atención a la retroalimentación visual, como indicadores de carga, diálogos de confirmación y mensajes de estado.

## Características Implementadas

*   **Autenticación de Usuarios:** Registro e inicio de sesión con Email/Contraseña usando Firebase Auth.
*   **Gestión de Equipos:**
    *   Listado reactivo de equipos desde Firestore.
    *   Añadir y editar equipos a través de un formulario dedicado.
    *   Eliminación de equipos con un diálogo de confirmación para prevenir acciones accidentales.
    *   **Búsqueda en tiempo real:** Filtrado dinámico de equipos por nombre o número de serial.
*   **Gestión de Mantenimientos:**
    *   Listado de mantenimientos para cada equipo.
    *   Formulario para añadir nuevos registros de mantenimiento.
*   **Navegación:**
    *   Enrutamiento basado en `go_router` para una navegación robusta y basada en URL.
    *   Barra de navegación inferior para un acceso rápido a las pantallas de Equipos y Perfil.
*   **Perfil de Usuario:** Pantalla simple para ver el email del usuario actual y cerrar sesión.
*   **Experiencia de Usuario Mejorada (UI/UX):**
    *   Uso de `CircularProgressIndicator` para indicar la carga de datos.
    *   Mensajes claros para el usuario cuando no hay datos (`"No se encontraron equipos."`) o cuando ocurren errores.
    *   Widgets de tarjeta (`EquipoCard`) para una visualización clara y consistente de la información del equipo.

---

## Resumen de la Sesión Actual: Depuración y Refinamiento

En esta sesión, el enfoque principal se desplazó de la implementación de nuevas características a la resolución de una serie de errores de análisis críticos que impedían la compilación del proyecto.

1.  **Diagnóstico del Problema:**
    *   Se identificaron 18 errores de análisis persistentes relacionados con la dependencia `flutter_riverpod`. Los errores indicaban que el analizador de Dart no podía encontrar clases fundamentales como `StateNotifier`, `StateNotifierProvider` y `StateProvider`, a pesar de que el paquete estaba listado en `pubspec.yaml`.

2.  **Intentos de Solución Iniciales:**
    *   Se ejecutó `flutter pub get` y `flutter pub upgrade` para intentar resolver las dependencias, sin éxito.
    *   Se eliminó el archivo `pubspec.lock` y se volvió a ejecutar `flutter pub get` para forzar una resolución limpia, pero los errores persistieron.
    *   Se ejecutó `flutter clean` para eliminar los artefactos de compilación y la caché, seguido de `flutter pub get`, lo que tampoco resolvió el problema.

3.  **Solución Definitiva (Conflicto de Versiones):**
    *   La causa raíz se identificó como un conflicto de versiones entre los paquetes de estado. El proyecto tenía tanto `provider` como `flutter_riverpod`, y las versiones resueltas automáticamente por `pub` eran incompatibles.
    *   **Acción Correctiva:**
        1.  Se eliminó la dependencia `provider` del `pubspec.yaml`, ya que `flutter_riverpod` era la solución de gestión de estado elegida.
        2.  Se actualizó explícitamente la versión de `flutter_riverpod` a `^2.5.1` para garantizar la compatibilidad y obtener las últimas correcciones.
    *   Tras aplicar estos cambios y ejecutar `flutter pub get`, todos los errores de análisis críticos se resolvieron.

4.  **Limpieza Final:**
    *   Se eliminaron las importaciones no utilizadas en `lib/router/router.dart` y `lib/screens/equipos_screen.dart` para dejar el código completamente limpio y sin advertencias.
    *   Se verificó con `flutter analyze` que el proyecto está ahora libre de errores y advertencias.

**El proyecto se encuentra ahora en un estado estable, funcional y libre de errores de análisis, con todas las características previstas implementadas.**
