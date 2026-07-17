
import 'package:flutter/foundation.dart';
import 'package:myapp/models/fichaje_model.dart';
import 'package:myapp/models/jugador_model.dart';
import 'package:myapp/models/club_model.dart';

class FichajeProvider with ChangeNotifier {
  final List<Fichaje> _fichajes = [];

  List<Fichaje> get fichajes => _fichajes;

  void agregarFichaje(Jugador jugador, Club clubOrigen, Club clubDestino) {
    final nuevoFichaje = Fichaje(
      id: DateTime.now().toString(),
      jugador: jugador,
      clubOrigen: clubOrigen,
      clubDestino: clubDestino,
      fecha: DateTime.now(),
    );
    _fichajes.add(nuevoFichaje);
    notifyListeners();
  }
}
