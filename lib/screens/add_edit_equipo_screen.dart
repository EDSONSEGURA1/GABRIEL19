import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventarios_unap/models/equipo.dart';
import 'package:inventarios_unap/providers/auth_provider.dart';
import 'package:inventarios_unap/providers/equipo_provider.dart';
import 'package:inventarios_unap/widgets/custom_elevated_button.dart';
import 'package:inventarios_unap/widgets/custom_text_form_field.dart';

class AddEditEquipoScreen extends ConsumerStatefulWidget {
  final Equipo? equipo;

  const AddEditEquipoScreen({super.key, this.equipo});

  @override
  ConsumerState<AddEditEquipoScreen> createState() => _AddEditEquipoScreenState();
}

class _AddEditEquipoScreenState extends ConsumerState<AddEditEquipoScreen> {
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
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _categoriaController.dispose();
    super.dispose();
  }

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      final userId = ref.read(authRepositoryProvider).getCurrentUser()?.uid;
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: No se pudo identificar al usuario.')),
        );
        return;
      }

      final notifier = ref.read(equiposProvider.notifier);
      final isEditing = widget.equipo != null;

      final nuevoEquipo = Equipo(
        id: widget.equipo?.id,
        userId: isEditing ? widget.equipo!.userId : userId,
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
        categoria: _categoriaController.text,
      );

      if (isEditing) {
        notifier.updateEquipo(nuevoEquipo);
      } else {
        notifier.addEquipo(nuevoEquipo);
      }
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.equipo != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Equipo' : 'Añadir Equipo'),
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
                labelText: 'Nombre del Equipo',
                validator: (value) => (value == null || value.isEmpty) ? 'El nombre es obligatorio' : null,
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                controller: _descripcionController,
                labelText: 'Descripción',
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                controller: _categoriaController,
                labelText: 'Categoría (Ej: Balón de Fútbol)',
              ),
              const SizedBox(height: 32.0),
              CustomElevatedButton(
                onPressed: _guardar,
                text: isEditing ? 'Guardar Cambios' : 'Añadir Equipo',
                icon: isEditing ? Icons.save : Icons.add,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
