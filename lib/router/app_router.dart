import 'package:go_router/go_router.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/screens/auth_screen.dart';
import 'package:myapp/screens/club_form_screen.dart';
import 'package:myapp/screens/club_list_screen.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/player_form_screen.dart';
import 'package:myapp/screens/player_list_screen.dart';
import 'package:myapp/screens/historial_fichajes_screen.dart';
import 'package:myapp/screens/fichaje_form_screen.dart'; // Importar
import 'package:myapp/models/club_model.dart';
import 'package:myapp/models/jugador_model.dart';

class AppRouter {
  final AuthProvider authProvider;

  AppRouter({required this.authProvider});

  late final GoRouter router = GoRouter(
    refreshListenable: authProvider,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/clubs',
        builder: (context, state) => const ClubListScreen(),
      ),
       GoRoute(
        path: '/club-form',
        builder: (context, state) => ClubFormScreen(club: state.extra as Club?),
      ),
      GoRoute(
        path: '/players',
        builder: (context, state) => const PlayerListScreen(),
      ),
      GoRoute(
        path: '/player-form',
        builder: (context, state) => PlayerFormScreen(jugador: state.extra as Jugador?),
      ),
      GoRoute(
        path: '/transfers',
        builder: (context, state) => const HistorialFichajesScreen(),
      ),
      GoRoute(
        path: '/fichaje-form', // Nueva ruta
        builder: (context, state) => const FichajeFormScreen(),
      ),
    ],
    redirect: (context, state) {
      final isAuthenticated = authProvider.user != null;
      final isLoggingIn = state.matchedLocation == '/login';

      if (!isAuthenticated && !isLoggingIn) {
        return '/login';
      }

      if (isAuthenticated && isLoggingIn) {
        return '/';
      }

      return null;
    },
  );
}
