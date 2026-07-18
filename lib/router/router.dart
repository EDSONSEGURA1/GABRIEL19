import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventarios_unap/models/equipo.dart';
import 'package:inventarios_unap/models/jugador.dart';
import 'package:inventarios_unap/providers/auth_provider.dart';
import 'package:inventarios_unap/screens/add_edit_equipo_screen.dart';
import 'package:inventarios_unap/screens/add_edit_jugador_screen.dart';
import 'package:inventarios_unap/screens/auth_screen.dart';
import 'package:inventarios_unap/screens/equipos_screen.dart';
import 'package:inventarios_unap/screens/home_screen.dart';
import 'package:inventarios_unap/screens/jugadores_screen.dart';
import 'package:inventarios_unap/screens/perfil_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  // Escucha el estado de autenticación. GoRouter reconstruirá cuando esto cambie.
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    // El refreshListenable ya no es necesario si la redirección se basa en un provider
    // que GoRouter escucha automáticamente gracias a ref.watch.
    redirect: (context, state) {
      // Usamos .when para manejar de forma segura los estados del AsyncValue
      final isLoggingIn = state.matchedLocation == '/';

      return authState.when(
        data: (user) {
          final isAuthenticated = user != null;
          if (!isAuthenticated && !isLoggingIn) {
            // Si no está autenticado y no está en la pantalla de login, redirige a login.
            return '/';
          }
          if (isAuthenticated && isLoggingIn) {
            // Si está autenticado y en la pantalla de login, redirige a la home.
            return '/equipos';
          }
          // En cualquier otro caso, no hay redirección.
          return null;
        },
        // Mientras carga el estado de auth, no hacemos nada. Evita redirecciones prematuras.
        loading: () => null,
        // En caso de error, podría ser útil redirigir a una pantalla de error o a login.
        error: (err, stack) => '/',
      );
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AuthScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // Solo mostramos la UI principal si el usuario está autenticado.
          // Esto previene un flash de la UI principal durante el arranque.
          if (authState.hasValue && authState.value != null) {
             return HomeScreen(navigationShell: navigationShell);
          }
          // Mientras tanto, se puede mostrar un loader o nada.
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/equipos',
                builder: (context, state) => const EquiposScreen(),
                routes: [
                  GoRoute(
                    path: 'add',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const AddEditEquipoScreen(),
                  ),
                  GoRoute(
                    path: 'edit',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) {
                      final equipo = state.extra as Equipo?;
                      return AddEditEquipoScreen(equipo: equipo);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/jugadores',
                builder: (context, state) => const JugadoresScreen(),
                 routes: [
                  GoRoute(
                    path: 'add',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const AddEditJugadorScreen(),
                  ),
                  GoRoute(
                    path: 'edit',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) {
                      final jugador = state.extra as Jugador?;
                      return AddEditJugadorScreen(jugador: jugador);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/perfil',
                builder: (context, state) => const PerfilScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
