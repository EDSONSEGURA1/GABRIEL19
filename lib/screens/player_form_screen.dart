import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/models/jugador_model.dart';
import 'package:myapp/models/club_model.dart';
import 'package:myapp/providers/jugador_provider.dart';
import 'package:myapp/providers/club_provider.dart';
import 'package:provider/provider.dart';

class PlayerFormScreen extends StatefulWidget {
  final Jugador? jugador;

  const PlayerFormScreen({super.key, this.jugador});

  @override
  PlayerFormScreenState createState() => PlayerFormScreenState();
}

class PlayerFormScreenState extends State<PlayerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _nombre;
  late int _edad;
  late String _posicion;
  String? _selectedClubId;
  late String _nombreClub;

  @override
  void initState() {
    super.initState();
    _nombre = widget.jugador?.nombre ?? '';
    _edad = widget.jugador?.edad ?? 0;
    _posicion = widget.jugador?.posicion ?? '';
    _selectedClubId = widget.jugador?.clubId;
    _nombreClub = widget.jugador?.nombreClub ?? 'Sin Club';
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final jugadorProvider = Provider.of<JugadorProvider>(context, listen: false);

      if (_selectedClubId == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecciona un club.')),
        );
        return;
      }

      final newOrUpdatedJugador = Jugador(
        id: widget.jugador?.id ?? '',
        nombre: _nombre,
        edad: _edad,
        posicion: _posicion,
        clubId: _selectedClubId!,
        nombreClub: _nombreClub,
      );

      if (widget.jugador == null) {
        await jugadorProvider.addJugador(newOrUpdatedJugador);
      } else {
        await jugadorProvider.updateJugador(newOrUpdatedJugador);
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.jugador == null ? 'Jugador añadido con éxito' : 'Jugador actualizado con éxito')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.jugador == null ? 'Añadir Jugador' : 'Editar Jugador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _nombre,
                decoration: const InputDecoration(labelText: 'Nombre del Jugador'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce un nombre.';
                  }
                  return null;
                },
                onSaved: (value) => _nombre = value!,
              ),
              TextFormField(
                initialValue: _edad == 0 ? '' : _edad.toString(),
                decoration: const InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Por favor, introduce una edad válida.';
                  }
                  return null;
                },
                onSaved: (value) => _edad = int.parse(value!),
              ),
              TextFormField(
                initialValue: _posicion,
                decoration: const InputDecoration(labelText: 'Posición'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce una posición.';
                  }
                  return null;
                },
                onSaved: (value) => _posicion = value!,
              ),
              StreamBuilder<List<Club>>(
                stream: Provider.of<ClubProvider>(context).clubs,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  var clubes = snapshot.data!;
                  return DropdownButtonFormField<String>(
                    initialValue: _selectedClubId,
                    hint: const Text('Selecciona un club'),
                    items: clubes.map((club) {
                      return DropdownMenuItem(
                        value: club.id,
                        child: Text(club.nombre),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedClubId = value;
                        if (value != null) {
                          _nombreClub = clubes.firstWhere((club) => club.id == value).nombre;
                        }
                      });
                    },
                    validator: (value) => value == null ? 'Campo requerido' : null,
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Guardar Jugador'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
