import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventarios_unap/models/equipo.dart';
import 'package:inventarios_unap/providers/auth_provider.dart';
import 'package:inventarios_unap/providers/equipo_provider.dart';

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
  late TextEditingController _serialController;
  late TextEditingController _modeloController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.equipo?.nombre ?? '');
    _descripcionController = TextEditingController(text: widget.equipo?.descripcion ?? '');
    _serialController = TextEditingController(text: widget.equipo?.serial ?? '');
    _modeloController = TextEditingController(text: widget.equipo?.modelo ?? '');
  }

  @override
  Widget build(BuildContext context) {
    // Se observa el estado de autenticación para obtener el userId
    final authState = ref.watch(authStateProvider);
    final userId = authState.when(
      data: (user) => user?.uid,
      loading: () => null,
      error: (_, __) => null,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.equipo == null ? 'Nuevo Equipo' : 'Editar Equipo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              TextFormField(
                controller: _serialController,
                decoration: const InputDecoration(labelText: 'Serial'),
              ),
              TextFormField(
                controller: _modeloController,
                decoration: const InputDecoration(labelText: 'Modelo'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && userId != null) {
                    final nuevoEquipo = Equipo(
                      id: widget.equipo?.id,
                      // El userId ya no se pasa aquí porque se añade en el notifier
                      userId: userId,
                      nombre: _nombreController.text,
                      descripcion: _descripcionController.text,
                      serial: _serialController.text,
                      modelo: _modeloController.text,
                    );

                    if (widget.equipo == null) {
                      ref.read(equiposProvider.notifier).addEquipo(nuevoEquipo);
                    } else {
                      ref.read(equiposProvider.notifier).updateEquipo(nuevoEquipo);
                    }
                    context.pop(); // Regresa a la pantalla anterior
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
