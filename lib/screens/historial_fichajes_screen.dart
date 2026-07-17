
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/fichaje_provider.dart';

class HistorialFichajesScreen extends StatelessWidget {
  const HistorialFichajesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fichajeProvider = Provider.of<FichajeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Fichajes'),
      ),
      body: ListView.builder(
        itemCount: fichajeProvider.fichajes.length,
        itemBuilder: (context, index) {
          final fichaje = fichajeProvider.fichajes[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                fichaje.jugador.nombre, // CORREGIDO: Eliminada la interpolación innecesaria
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'De: ${fichaje.clubOrigen.nombre}\nA: ${fichaje.clubDestino.nombre}'),
              trailing: Text(fichaje.fecha.toLocal().toString().split(' ')[0]),
            ),
          );
        },
      ),
    );
  }
}
