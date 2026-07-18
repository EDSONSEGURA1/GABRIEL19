import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventarios_unap/models/mantenimiento.dart';
import 'package:inventarios_unap/providers/mantenimiento_provider.dart';

class MantenimientoForm extends ConsumerStatefulWidget {
  final String equipoId;
  const MantenimientoForm({super.key, required this.equipoId});

  @override
  ConsumerState<MantenimientoForm> createState() => _MantenimientoFormState();
}

class _MantenimientoFormState extends ConsumerState<MantenimientoForm> {
  final _descripcionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Mantenimiento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 20),
            Text('Fecha: ${_selectedDate.toLocal()}'.split(' ')[0]),
            ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != _selectedDate) {
                  setState(() {
                    _selectedDate = picked;
                  });
                }
              },
              child: const Text('Seleccionar fecha'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final nuevoMantenimiento = Mantenimiento(
                  equipoId: widget.equipoId,
                  fecha: _selectedDate,
                  descripcion: _descripcionController.text,
                );
                ref.read(mantenimientosProvider(widget.equipoId).notifier).addMantenimiento(nuevoMantenimiento);
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
