import 'package:flutter/material.dart';
import 'package:inventarios_unap/models/equipo.dart';

class EquipoCard extends StatelessWidget {
  final Equipo equipo;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const EquipoCard({
    super.key,
    required this.equipo,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(equipo.nombre, style: theme.textTheme.titleLarge),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (equipo.descripcion != null && equipo.descripcion!.isNotEmpty)
              Text(equipo.descripcion!),
            if (equipo.categoria != null && equipo.categoria!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Chip(label: Text(equipo.categoria!)),
              ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}
