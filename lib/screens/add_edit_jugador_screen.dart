import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventarios_unap/models/jugador.dart';
import 'package:inventarios_unap/providers/jugador_provider.dart';
import 'package:inventarios_unap/widgets/custom_elevated_button.dart';
import 'package:inventarios_unap/widgets/custom_text_form_field.dart';

class AddEditJugadorScreen extends ConsumerStatefulWidget {
  final Jugador? jugador; // Jugador existente si se está editando

  const AddEditJugadorScreen({super.key, this.jugador});

  @override
  ConsumerState<AddEditJugadorScreen> createState() => _AddEditJugadorScreenState();
}

class _AddEditJugadorScreenState extends ConsumerState<AddEditJugadorScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _posicionController;
  late TextEditingController _edadController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.jugador?.nombre ?? '');
    _posicionController = TextEditingController(text: widget.jugador?.posicion ?? '');
    _edadController = TextEditingController(text: widget.jugador?.edad ?? '');
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _posicionController.dispose();
    _edadController.dispose();
    super.dispose();
  }

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      final notifier = ref.read(jugadoresProvider.notifier);
      final isEditing = widget.jugador != null;

      final nuevoJugador = Jugador(
        id: widget.jugador?.id,
        userId: '', // El repositorio se encargará de esto
        nombre: _nombreController.text,
        posicion: _posicionController.text,
        edad: _edadController.text,
      );

      if (isEditing) {
        notifier.updateJugador(nuevoJugador);
      } else {
        notifier.addJugador(nuevoJugador);
      }
      context.pop(); // Volver a la pantalla anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.jugador != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Jugador' : 'Añadir Jugador'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextFormField(
                controller: _nombreController,
                labelText: 'Nombre del Jugador',
                validator: (value) => (value == null || value.isEmpty) ? 'El nombre es obligatorio' : null,
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                controller: _posicionController,
                labelText: 'Posición (Ej: Delantero)',
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                controller: _edadController,
                labelText: 'Edad',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 32.0),
              CustomElevatedButton(
                onPressed: _guardar,
                text: isEditing ? 'Guardar Cambios' : 'Añadir Jugador',
                icon: isEditing ? Icons.save : Icons.add,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
