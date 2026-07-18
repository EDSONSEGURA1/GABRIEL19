
import 'package:cloud_firestore/cloud_firestore.dart';

class Jugador {
  final String? id;
  final String userId;
  final String nombre;
  final String? posicion;
  final String? edad;

  Jugador({
    this.id,
    required this.userId,
    required this.nombre,
    this.posicion,
    this.edad,
  });

  // Método para convertir un documento de Firestore a un objeto Jugador
  factory Jugador.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return Jugador(
      id: snapshot.id,
      userId: data?['userId'] ?? '',
      nombre: data?['nombre'] ?? '',
      posicion: data?['posicion'],
      edad: data?['edad'],
    );
  }

  // Método para convertir un objeto Jugador a un mapa para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'nombre': nombre,
      if (posicion != null) 'posicion': posicion,
      if (edad != null) 'edad': edad,
    };
  }

    // Método para crear una copia del objeto con algunos campos modificados
  Jugador copyWith({
    String? id,
    String? userId,
    String? nombre,
    String? posicion,
    String? edad,
  }) {
    return Jugador(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      nombre: nombre ?? this.nombre,
      posicion: posicion ?? this.posicion,
      edad: edad ?? this.edad,
    );
  }
}
