import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventarios_unap/models/equipo.dart';
import 'package:inventarios_unap/providers/auth_provider.dart';
import 'package:inventarios_unap/providers/equipo_provider.dart';
import 'package:inventarios_unap/widgets/custom_elevated_button.dart'; // Importamos el nuevo widget

class EquipoFormScreen extends ConsumerStatefulWidget {
  final Equipo? equipo;

  const EquipoFormScreen({super.key, this.equipo});

  @override
  ConsumerState<EquipoFormScreen> createState() => _EquipoFormScreenState();
}

class _EquipoFormScreenState extends ConsumerState<EquipoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  late TextEditingController _categoriaController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.equipo?.nombre ?? '');
    _descripcionController = TextEditingController(text: widget.equipo?.descripcion ?? '');
    _categoriaController = TextEditingController(text: widget.equipo?.categoria ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final userId = authState.when(
      data: (user) => user?.uid,
      loading: () => null,
      error: (_, __) => null,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.equipo == null ? 'Añadir Equipo' : 'Editar Equipo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre del Equipo'),
                validator: (value) => value!.isEmpty ? 'El nombre es requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción (opcional)'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoriaController,
                decoration: const InputDecoration(labelText: 'Categoría (ej: Liga A, Amistoso)'),
              ),
              const SizedBox(height: 30),
              // Reemplazamos ElevatedButton por nuestro CustomElevatedButton
              CustomElevatedButton(
                text: 'Guardar Equipo',
                icon: Icons.save,
                onPressed: () {
                  if (_formKey.currentState!.validate() && userId != null) {
                    final nuevoEquipo = Equipo(
                      id: widget.equipo?.id,
                      userId: userId,
                      nombre: _nombreController.text,
                      descripcion: _descripcionController.text,
                      categoria: _categoriaController.text,
                    );

                    if (widget.equipo == null) {
                      ref.read(equiposProvider.notifier).addEquipo(nuevoEquipo);
                    } else {
                      ref.read(equiposProvider.notifier).updateEquipo(nuevoEquipo);
                    }
                    context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
