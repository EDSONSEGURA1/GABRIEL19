import 'package:cloud_firestore/cloud_firestore.dart';

// Modelo para un Jugador
class Player {
  final String? id;
  final String teamId; // ID del equipo al que pertenece
  final String name; // Nombre del jugador
  final String? position; // Posición en el campo (delantero, defensa, etc.)
  final int? number; // Número de camiseta

  Player({
    this.id,
    required this.teamId,
    required this.name,
    this.position,
    this.number,
  });

  factory Player.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Player(
      id: doc.id,
      teamId: data['teamId'],
      name: data['name'],
      position: data['position'],
      number: data['number'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'teamId': teamId,
      'name': name,
      'position': position,
      'number': number,
    };
  }
}
