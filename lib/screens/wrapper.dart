import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventarios_unap/providers/auth_provider.dart';
import 'package:inventarios_unap/screens/auth_screen.dart';
import 'package:inventarios_unap/screens/equipos_screen.dart'; // O la pantalla principal que desees
import 'package:inventarios_unap/widgets/bottom_nav_bar.dart';

class Wrapper extends ConsumerWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          return const AuthScreen();
        } else {
          return const Scaffold(
            body: EquiposScreen(), // La pantalla por defecto al estar logueado
            bottomNavigationBar: BottomNavBar(),
          );
        }
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(child: Text('Error de autenticación: $error')),
      ),
    );
  }
}
