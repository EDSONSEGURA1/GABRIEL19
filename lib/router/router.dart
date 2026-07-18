import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventarios_unap/models/equipo.dart';
import 'package:inventarios_unap/screens/auth_screen.dart';
import 'package:inventarios_unap/screens/equipo_form_screen.dart';
import 'package:inventarios_unap/screens/equipos_screen.dart';
import 'package:inventarios_unap/screens/jugadores_screen.dart';
import 'package:inventarios_unap/screens/perfil_screen.dart';
import 'package:inventarios_unap/widgets/scaffold_with_nav_bar.dart';

// Clave global para el `StatefulNavigationShell`
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    // Ruta de autenticación fuera del Shell
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthScreen(),
    ),

    // `StatefulShellRoute` para la navegación con pestañas
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // El widget que contiene la `BottomNavigationBar`
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        // 1. Rama de Equipos
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/equipos',
              builder: (context, state) => const EquiposScreen(),
              routes: [
                // Sub-ruta para el formulario de equipos
                GoRoute(
                  path: 'new',
                  parentNavigatorKey: _rootNavigatorKey, // Para que se muestre sobre el Shell
                  builder: (context, state) => const EquipoFormScreen(),
                ),
                GoRoute(
                  path: ':id',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final equipo = state.extra as Equipo?;
                    return EquipoFormScreen(equipo: equipo);
                  },
                ),
              ],
            ),
          ],
        ),

        // 2. Rama de Jugadores
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/jugadores',
              builder: (context, state) => const JugadoresScreen(),
            ),
          ],
        ),

        // 3. Rama de Perfil
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
