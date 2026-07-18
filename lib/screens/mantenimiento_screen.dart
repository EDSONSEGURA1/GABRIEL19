import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventarios_unap/models/equipo.dart';
import 'package:inventarios_unap/models/mantenimiento.dart';
import 'package:inventarios_unap/providers/mantenimiento_provider.dart';

class MantenimientoScreen extends ConsumerStatefulWidget {
  final Equipo equipo;

  const MantenimientoScreen({super.key, required this.equipo});

  @override
  ConsumerState<MantenimientoScreen> createState() => _MantenimientoScreenState();
}

class _MantenimientoScreenState extends ConsumerState<MantenimientoScreen> {
  final _descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mantenimientosAsyncValue = ref.watch(mantenimientosProvider(widget.equipo.id!));

    return Scaffold(
      appBar: AppBar(
        title: Text('Mantenimiento de ${widget.equipo.nombre}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _descripcionController,
                    decoration: const InputDecoration(
                      labelText: 'Nueva observación de mantenimiento',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (_descripcionController.text.isNotEmpty) {
                      final nuevoMantenimiento = Mantenimiento(
                        equipoId: widget.equipo.id!,
                        fecha: DateTime.now(),
                        descripcion: _descripcionController.text,
                      );
                      ref.read(mantenimientosProvider(widget.equipo.id!).notifier)
                         .addMantenimiento(nuevoMantenimiento);
                      _descripcionController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: mantenimientosAsyncValue.when(
              data: (mantenimientos) {
                if (mantenimientos.isEmpty) {
                  return const Center(
                    child: Text('No hay registros de mantenimiento.'),
                  );
                }
                return ListView.builder(
                  itemCount: mantenimientos.length,
                  itemBuilder: (context, index) {
                    final mantenimiento = mantenimientos[index];
                    return ListTile(
                      title: Text(mantenimiento.descripcion),
                      subtitle: Text(mantenimiento.fecha.toLocal().toString()),
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
