import 'package:flutter/material.dart';
import 'package:inventarios_unap/models/equipo.dart';

class EquipoCard extends StatelessWidget {
  final Equipo equipo;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const EquipoCard({super.key, required this.equipo, required this.onTap, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(equipo.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Serial: ${equipo.serial ?? 'N/A'}'),
            Text('Modelo: ${equipo.modelo ?? 'N/A'}'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}
