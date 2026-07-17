
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/jugador_model.dart';
import 'package:myapp/models/club_model.dart';
import 'package:myapp/providers/jugador_provider.dart';
import 'package:myapp/providers/club_provider.dart';
import 'package:myapp/providers/fichaje_provider.dart';

class FichajeFormScreen extends StatefulWidget {
  const FichajeFormScreen({super.key});

  @override
  FichajeFormScreenState createState() => FichajeFormScreenState();
}

class FichajeFormScreenState extends State<FichajeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  Jugador? _selectedJugador;
  Club? _selectedClubOrigen;
  Club? _selectedClubDestino;

  @override
  Widget build(BuildContext context) {
    final jugadorProvider = Provider.of<JugadorProvider>(context, listen: false);
    final clubProvider = Provider.of<ClubProvider>(context, listen: false);
    final fichajeProvider = Provider.of<FichajeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Fichaje'),
      ),
      body: StreamBuilder<List<Jugador>>(
        stream: jugadorProvider.allJugadores,
        builder: (context, jugadorSnapshot) {
          if (jugadorSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!jugadorSnapshot.hasData || jugadorSnapshot.data!.isEmpty) {
            return const Center(child: Text('No hay jugadores disponibles.'));
          }
          final jugadores = jugadorSnapshot.data!;

          return StreamBuilder<List<Club>>(
            stream: clubProvider.clubs,
            builder: (context, clubSnapshot) {
              if (clubSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!clubSnapshot.hasData || clubSnapshot.data!.isEmpty) {
                return const Center(child: Text('No hay clubes disponibles.'));
              }
              final clubes = clubSnapshot.data!;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButtonFormField<Jugador>(
                        // CORREGIDO: Se elimina la propiedad 'value' obsoleta.
                        decoration: const InputDecoration(labelText: 'Jugador'),
                        items: jugadores.map((jugador) {
                          return DropdownMenuItem<Jugador>(
                            value: jugador,
                            child: Text(jugador.nombre),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedJugador = value;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Seleccione un jugador' : null,
                      ),
                      DropdownButtonFormField<Club>(
                        // CORREGIDO: Se elimina la propiedad 'value' obsoleta.
                        decoration: const InputDecoration(labelText: 'Club Origen'),
                        items: clubes.map((club) {
                          return DropdownMenuItem<Club>(
                            value: club,
                            child: Text(club.nombre),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedClubOrigen = value;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Seleccione un club de origen' : null,
                      ),
                      DropdownButtonFormField<Club>(
                        // CORREGIDO: Se elimina la propiedad 'value' obsoleta.
                        decoration: const InputDecoration(labelText: 'Club Destino'),
                        items: clubes.map((club) {
                          return DropdownMenuItem<Club>(
                            value: club,
                            child: Text(club.nombre),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedClubDestino = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Seleccione un club de destino';
                          }
                          if (value == _selectedClubOrigen) {
                            return 'El club de destino no puede ser el mismo que el de origen.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            fichajeProvider.agregarFichaje(
                              _selectedJugador!,
                              _selectedClubOrigen!,
                              _selectedClubDestino!,
                            );
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Guardar Fichaje'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
