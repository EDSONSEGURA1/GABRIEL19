import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestor de Fichajes de Fútbol'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar Sesión',
            onPressed: () async {
              await authProvider.signOut();
            },
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0, // Ratio para que las tarjetas se vean bien
        children: <Widget>[
          _buildMenuCard(
            context,
            icon: Icons.shield,
            title: 'Clubes',
            route: '/clubs',
          ),
          _buildMenuCard(
            context,
            icon: Icons.person,
            title: 'Jugadores',
            route: '/players',
          ),
          _buildMenuCard(
            context,
            icon: Icons.swap_horiz_rounded,
            title: 'Historial de Fichajes',
            route: '/transfers',
          ),
          _buildMenuCard(
            context,
            icon: Icons.add_box_rounded,
            title: 'Nuevo Fichaje',
            route: '/fichaje-form',
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {required IconData icon, required String title, required String route}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => context.go(route),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 70.0, color: Theme.of(context).primaryColor),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
