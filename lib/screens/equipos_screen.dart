import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventarios_unap/providers/equipo_provider.dart';
import 'package:inventarios_unap/widgets/equipo_card.dart';

// Provider para el término de búsqueda
final searchQueryProvider = StateProvider<String>((ref) => '');

class EquiposScreen extends ConsumerWidget {
  const EquiposScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final equiposAsyncValue = ref.watch(equiposProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    // Función para mostrar diálogo de confirmación
    Future<bool> showConfirmationDialog(BuildContext context) async {
      return await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Confirmar Eliminación'),
              content: const Text('¿Estás seguro de que deseas eliminar este equipo?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Eliminar'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario de Equipos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/equipo/new'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
              decoration: const InputDecoration(
                labelText: 'Buscar por nombre o serial',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: equiposAsyncValue.when(
              data: (equipos) {
                final filteredEquipos = equipos.where((equipo) {
                  final query = searchQuery.toLowerCase();
                  return equipo.nombre.toLowerCase().contains(query) ||
                      (equipo.serial?.toLowerCase().contains(query) ?? false);
                }).toList();

                if (filteredEquipos.isEmpty) {
                  return const Center(child: Text('No se encontraron equipos.'));
                }
                return ListView.builder(
                  itemCount: filteredEquipos.length,
                  itemBuilder: (context, index) {
                    final equipo = filteredEquipos[index];
                    return EquipoCard(
                      equipo: equipo,
                      onTap: () => context.go('/equipo/:${equipo.id}', extra: equipo),
                      onDelete: () async {
                        final confirmed = await showConfirmationDialog(context);
                        if (confirmed) {
                          ref.read(equiposProvider.notifier).deleteEquipo(equipo.id!);
                        }
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
