import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/theme_provider.dart'; // Importación más específica

class HomeLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const HomeLayout({super.key, required this.navigationShell});

  static const List<String> _titles = [
    'Gestión de Alumnos',
    'Control de Materias',
    'Asignación de Cursos',
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[navigationShell.currentIndex]),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
            tooltip: themeProvider.isDarkMode ? 'Activar Modo Claro' : 'Activar Modo Oscuro',
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
             UserAccountsDrawerHeader(
              // El color del header del drawer ahora depende del tema
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                child: Icon(
                  Icons.person_rounded,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              accountName: Text(
                'Administrador',
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              accountEmail: Text(
                'admin@aitec.edu.ec',
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary.withAlpha(204)),
                ),
            ),
            ListTile(
              leading: const Icon(Icons.school_rounded),
              title: const Text('Alumnos'),
              selected: navigationShell.currentIndex == 0,
              onTap: () => _onTabTapped(context, 0),
            ),
            ListTile(
              leading: const Icon(Icons.book_rounded),
              title: const Text('Materias'),
              selected: navigationShell.currentIndex == 1,
              onTap: () => _onTabTapped(context, 1),
            ),
            ListTile(
              leading: const Icon(Icons.assignment_turned_in_rounded),
              title: const Text('Asignar Cursos'),
              selected: navigationShell.currentIndex == 2,
              onTap: () => _onTabTapped(context, 2),
            ),
            const Divider(),
            const Spacer(),
            ListTile(
              leading: Icon(Icons.logout_rounded, color: Theme.of(context).colorScheme.error),
              title: Text(
                'Cerrar Sesión',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              onTap: () {
                context.go('/login');
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      body: navigationShell,
    );
  }

  void _onTabTapped(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
    Navigator.pop(context); // Cierra el Drawer automáticamente
  }
}
