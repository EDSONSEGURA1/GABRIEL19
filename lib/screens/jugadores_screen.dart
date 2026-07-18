import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventarios_unap/providers/jugador_provider.dart';
import 'package:inventarios_unap/widgets/jugador_card.dart';

class JugadoresScreen extends ConsumerWidget {
  const JugadoresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jugadoresAsync = ref.watch(jugadoresProvider);
    final notifier = ref.read(jugadoresProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Jugadores'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => context.go('/jugadores/add'),
            tooltip: 'Añadir Jugador',
          ),
        ],
      ),
      body: jugadoresAsync.when(
        data: (jugadores) {
          if (jugadores.isEmpty) {
            return const Center(
              child: Text(
                'Aún no has añadido jugadores. ¡Empieza ahora!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
            );
          }
          return ListView.builder(
            itemCount: jugadores.length,
            itemBuilder: (context, index) {
              final jugador = jugadores[index];
              return JugadorCard(
                jugador: jugador,
                onTap: () => context.go('/jugadores/edit', extra: jugador),
                onDelete: () {
                  // Mostrar diálogo de confirmación
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirmar Eliminación'),
                        content: Text('¿Estás seguro de que deseas eliminar a ${jugador.nombre}?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cancelar'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(foregroundColor: Colors.red),
                            child: const Text('Eliminar'),
                            onPressed: () {
                              notifier.deleteJugador(jugador.id!); 
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
