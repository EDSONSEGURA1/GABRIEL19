import 'package:flutter/material.dart';
import 'package:myapp/models/fichaje_model.dart';
import 'package:myapp/providers/fichaje_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HistorialFichajesScreen extends StatelessWidget {
  const HistorialFichajesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Fichajes'),
      ),
      body: StreamBuilder<List<Fichaje>>(
        stream: Provider.of<FichajeProvider>(context).historialFichajes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Aún no se han realizado fichajes.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          final fichajes = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: fichajes.length,
            itemBuilder: (context, index) {
              final fichaje = fichajes[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: ListTile(
                  leading: const Icon(Icons.swap_horiz, color: Colors.indigo, size: 40),
                  title: Text(
                    fichaje.nombreJugador,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('De: ${fichaje.nombreClubOrigen}'),
                      Text('A: ${fichaje.nombreClubDestino}'),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('dd/MM/yyyy, HH:mm').format(fichaje.fecha),
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
