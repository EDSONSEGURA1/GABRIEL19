import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/jugador_model.dart';
import 'package:myapp/models/club_model.dart';
import 'package:myapp/providers/jugador_provider.dart';
import 'package:myapp/providers/club_provider.dart';
import 'package:myapp/providers/fichaje_provider.dart';

class PlayerListScreen extends StatelessWidget {
  const PlayerListScreen({super.key});

  void _mostrarDialogoFichaje(BuildContext context, Jugador jugador, List<Club> clubes) {
    final fichajeProvider = Provider.of<FichajeProvider>(context, listen: false);
    final clubesDisponibles = clubes.where((club) => club.id != jugador.clubId).toList();

    // CORREGIDO: Creación del Club de Origen con todos los campos requeridos.
    final clubOrigen = clubes.firstWhere(
      (club) => club.id == jugador.clubId,
      // El fallback ahora construye un objeto Club válido.
      orElse: () => Club(id: 'unknown', nombre: 'Desconocido', estadio: 'N/A', fundacion: 0),
    );

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Fichar a ${jugador.nombre}'),
          content: SizedBox(
            width: double.maxFinite,
            child: clubesDisponibles.isEmpty
                ? const Text('No hay otros clubes a los que fichar al jugador.')
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: clubesDisponibles.length,
                    itemBuilder: (context, index) {
                      final clubDestino = clubesDisponibles[index];
                      return ListTile(
                        title: Text(clubDestino.nombre),
                        onTap: () {
                          Navigator.of(dialogContext).pop();
                          fichajeProvider.agregarFichaje(
                            jugador,
                            clubOrigen,
                            clubDestino,
                          );
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${jugador.nombre} fichado por ${clubDestino.nombre}!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jugadores'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/player-form'),
          ),
        ],
      ),
      body: StreamBuilder<List<Jugador>>(
        stream: Provider.of<JugadorProvider>(context).allJugadores,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay jugadores. ¡Añade uno!'));
          }

          final jugadores = snapshot.data!;

          return StreamBuilder<List<Club>>(
            stream: Provider.of<ClubProvider>(context).clubs,
            builder: (context, clubSnapshot) {
              if (clubSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final clubes = clubSnapshot.hasData ? clubSnapshot.data! : <Club>[];

              return ListView.builder(
                itemCount: jugadores.length,
                itemBuilder: (context, index) {
                  final jugador = jugadores[index];
                  return ListTile(
                    title: Text(jugador.nombre),
                    subtitle: Text(jugador.nombreClub),
                    leading: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.grey),
                      onPressed: () => context.go('/player-form', extra: jugador),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.swap_horiz, color: Colors.indigo),
                          tooltip: 'Fichar',
                          onPressed: () => _mostrarDialogoFichaje(context, jugador, clubes),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          tooltip: 'Eliminar',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Confirmar Eliminación'),
                                content: Text('¿Seguro que quieres eliminar a ${jugador.nombre}?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(ctx).pop(),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Provider.of<JugadorProvider>(context, listen: false).deleteJugador(jugador.id);
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
