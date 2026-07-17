import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/models/club_model.dart';
import 'package:myapp/providers/club_provider.dart';
import 'package:provider/provider.dart';

class ClubFormScreen extends StatefulWidget {
  final Club? club;

  const ClubFormScreen({super.key, this.club});

  @override
  State<ClubFormScreen> createState() => _ClubFormScreenState();
}

class _ClubFormScreenState extends State<ClubFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _nombre;
  late String _estadio;
  late int _fundacion;

  @override
  void initState() {
    super.initState();
    _nombre = widget.club?.nombre ?? '';
    _estadio = widget.club?.estadio ?? '';
    _fundacion = widget.club?.fundacion ?? DateTime.now().year;
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final clubProvider = Provider.of<ClubProvider>(context, listen: false);

      final newOrUpdatedClub = Club(
        id: widget.club?.id ?? '', // El ID es importante para la actualización
        nombre: _nombre,
        estadio: _estadio,
        fundacion: _fundacion,
      );

      if (widget.club == null) {
        clubProvider.addClub(newOrUpdatedClub);
      } else {
        clubProvider.updateClub(newOrUpdatedClub);
      }
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.club == null ? 'Añadir Club' : 'Editar Club'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView( // Usamos ListView para evitar overflow si el teclado aparece
            children: <Widget>[
              TextFormField(
                initialValue: _nombre,
                decoration: const InputDecoration(labelText: 'Nombre del Club', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Por favor, introduce un nombre.';
                  return null;
                },
                onSaved: (value) => _nombre = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _estadio,
                decoration: const InputDecoration(labelText: 'Estadio', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Por favor, introduce un estadio.';
                  return null;
                },
                onSaved: (value) => _estadio = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _fundacion.toString(),
                decoration: const InputDecoration(labelText: 'Año de Fundación', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Por favor, introduce un año válido.';
                  }
                  return null;
                },
                onSaved: (value) => _fundacion = int.parse(value!),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveForm,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Guardar Club'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
