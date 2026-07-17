import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/club_model.dart';
import 'package:myapp/providers/club_provider.dart';

class ClubListScreen extends StatelessWidget {
  const ClubListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clubes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.go('/club-form');
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Club>>(
        stream: Provider.of<ClubProvider>(context).clubs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No se encontraron clubes. ¡Añade uno!',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final clubes = snapshot.data!;

          return ListView.builder(
            itemCount: clubes.length,
            itemBuilder: (context, index) {
              final club = clubes[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                elevation: 3,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(Icons.shield, color: Colors.white),
                  ),
                  title: Text(club.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Estadio: ${club.estadio}'),
                  onTap: () {
                    context.go('/club-form', extra: club);
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    tooltip: 'Eliminar',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: const Text('Confirmar Eliminación'),
                            content: Text('¿Estás seguro de que quieres eliminar a ${club.nombre}?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Eliminar', style: TextStyle(color: Colors.redAccent)),
                                onPressed: () {
                                  Provider.of<ClubProvider>(context, listen: false).deleteClub(club.id);
                                  Navigator.of(ctx).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('${club.nombre} eliminado.')),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
