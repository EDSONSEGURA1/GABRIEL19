import 'package:cloud_firestore/cloud_firestore.dart';

// Representa una transferencia o fichaje de un jugador entre dos clubes.
class Fichaje {
  final String id;
  final String jugadorId;
  final String nombreJugador; // Denormalizado para mostrarlo fácilmente
  final String clubOrigenId;
  final String nombreClubOrigen; // Denormalizado
  final String clubDestinoId;
  final String nombreClubDestino; // Denormalizado
  final DateTime fecha;

  Fichaje({
    this.id = '',
    required this.jugadorId,
    required this.nombreJugador,
    required this.clubOrigenId,
    required this.nombreClubOrigen,
    required this.clubDestinoId,
    required this.nombreClubDestino,
    required this.fecha,
  });

  // Convierte este objeto Fichaje a un mapa para guardarlo en Firestore.
  Map<String, dynamic> toMap() {
    return {
      'jugadorId': jugadorId,
      'nombreJugador': nombreJugador,
      'clubOrigenId': clubOrigenId,
      'nombreClubOrigen': nombreClubOrigen,
      'clubDestinoId': clubDestinoId,
      'nombreClubDestino': nombreClubDestino,
      'fecha': Timestamp.fromDate(fecha), // Firestore usa Timestamps para fechas
    };
  }

  // Crea un objeto Fichaje a partir de un mapa de datos de Firestore.
  factory Fichaje.fromMap(Map<String, dynamic> map, String documentId) {
    return Fichaje(
      id: documentId,
      jugadorId: map['jugadorId'] ?? '',
      nombreJugador: map['nombreJugador'] ?? '',
      clubOrigenId: map['clubOrigenId'] ?? '',
      nombreClubOrigen: map['nombreClubOrigen'] ?? '',
      clubDestinoId: map['clubDestinoId'] ?? '',
      nombreClubDestino: map['nombreClubDestino'] ?? '',
      fecha: (map['fecha'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
