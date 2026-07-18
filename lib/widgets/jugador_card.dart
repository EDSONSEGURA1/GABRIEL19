import 'package:flutter/material.dart';
import 'package:inventarios_unap/models/jugador.dart';

class JugadorCard extends StatelessWidget {
  final Jugador jugador;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const JugadorCard({super.key, required this.jugador, required this.onTap, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withAlpha(25),
                child: Icon(Icons.person, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jugador.nombre,
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    if (jugador.posicion != null && jugador.posicion!.isNotEmpty)
                      Text(
                        'Posición: ${jugador.posicion}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    if (jugador.edad != null && jugador.edad!.isNotEmpty)
                      Text(
                        'Edad: ${jugador.edad} años',
                        style: theme.textTheme.bodyMedium,
                      ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
                onPressed: onDelete,
                tooltip: 'Eliminar Jugador',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
