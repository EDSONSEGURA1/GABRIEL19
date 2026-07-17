import 'package:myapp/models/club_model.dart';
import 'package:myapp/models/jugador_model.dart';

class Fichaje {
  final String id;
  final Jugador jugador;
  final Club clubOrigen;
  final Club clubDestino;
  final DateTime fecha;

  Fichaje({
    required this.id,
    required this.jugador,
    required this.clubOrigen,
    required this.clubDestino,
    required this.fecha,
  });
}
