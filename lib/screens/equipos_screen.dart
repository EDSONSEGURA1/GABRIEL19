import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventarios_unap/providers/equipo_provider.dart';
import 'package:inventarios_unap/widgets/equipo_card.dart';

// Provider para el término de búsqueda
final searchQueryProvider = StateProvider<String>((ref) => '');
// Provider para la categoría seleccionada
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

class EquiposScreen extends ConsumerWidget {
  const EquiposScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final equiposAsyncValue = ref.watch(equiposProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    Future<bool> showConfirmationDialog(BuildContext context) async {
      return await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Confirmar Eliminación'),
              content: const Text('¿Estás seguro de que deseas eliminar este equipo?'),
              actions: [
                TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancelar')),
                TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Eliminar')),
              ],
            ),
          ) ??
          false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Equipos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            // Ruta actualizada para el nuevo router
            onPressed: () => context.go('/equipos/new'), 
            tooltip: 'Añadir Equipo',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
              decoration: const InputDecoration(labelText: 'Buscar por nombre', prefixIcon: Icon(Icons.search), border: OutlineInputBorder()),
            ),
          ),
          Expanded(
            child: equiposAsyncValue.when(
              data: (equipos) {
                final categories = equipos.map((e) => e.categoria).where((c) => c != null && c.isNotEmpty).toSet().toList();

                final filteredEquipos = equipos.where((equipo) {
                  final searchMatch = equipo.nombre.toLowerCase().contains(searchQuery.toLowerCase());
                  final categoryMatch = selectedCategory == null || equipo.categoria == selectedCategory;
                  return searchMatch && categoryMatch;
                }).toList();

                if (equipos.isEmpty) {
                  return const Center(child: Text('No se encontraron equipos. Pulsa + para añadir uno.'));
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (categories.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ChoiceChip(
                                label: const Text('Todos'),
                                selected: selectedCategory == null,
                                onSelected: (selected) => ref.read(selectedCategoryProvider.notifier).state = null,
                              ),
                              ...categories.map((category) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: ChoiceChip(
                                      label: Text(category!),
                                      selected: selectedCategory == category,
                                      onSelected: (selected) => ref.read(selectedCategoryProvider.notifier).state = category,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    Expanded(
                      child: filteredEquipos.isEmpty
                          ? const Center(child: Text('No hay equipos que coincidan con el filtro.'))
                          : ListView.builder(
                              itemCount: filteredEquipos.length,
                              itemBuilder: (context, index) {
                                final equipo = filteredEquipos[index];
                                return EquipoCard(
                                  equipo: equipo,
                                  // Ruta actualizada para el nuevo router
                                  onTap: () => context.go('/equipos/${equipo.id}', extra: equipo),
                                  onDelete: () async {
                                    final confirmed = await showConfirmationDialog(context);
                                    if (confirmed) {
                                      ref.read(equiposProvider.notifier).deleteEquipo(equipo.id!);
                                    }
                                  },
                                );
                              },
                            ),
                    ),
                  ],
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
