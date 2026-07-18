import 'package:go_router/go_router.dart';
import 'package:inventarios_unap/models/equipo.dart';
import 'package:inventarios_unap/screens/auth_screen.dart';
import 'package:inventarios_unap/screens/equipo_form_screen.dart';
import 'package:inventarios_unap/screens/equipos_screen.dart';
import 'package:inventarios_unap/screens/mantenimiento_screen.dart';
import 'package:inventarios_unap/screens/perfil_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const EquiposScreen(), // Redirige a equipos por defecto
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/equipos',
      builder: (context, state) => const EquiposScreen(),
    ),
    GoRoute(
      path: '/equipo/new',
      builder: (context, state) => const EquipoFormScreen(),
    ),
    GoRoute(
      path: '/equipo/:id',
      builder: (context, state) {
        final equipo = state.extra as Equipo?;
        return EquipoFormScreen(equipo: equipo);
      },
    ),
    GoRoute(
      path: '/mantenimiento/:equipoId',
      builder: (context, state) {
        final equipo = state.extra as Equipo;
        return MantenimientoScreen(equipo: equipo);
      },
    ),
    GoRoute(
      path: '/perfil',
      builder: (context, state) => const PerfilScreen(),
    ),
  ],
  redirect: (context, state) {
    // Lógica de redirección basada en la autenticación se manejará en main.dart
    return null;
  },
);
