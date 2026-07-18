import 'package:cloud_firestore/cloud_firestore.dart';

class Equipo {
  final String? id;
  final String userId;
  final String nombre;
  final String? descripcion;
  final String? serial;
  final String? modelo;

  Equipo({
    this.id,
    required this.userId,
    required this.nombre,
    this.descripcion,
    this.serial,
    this.modelo,
  });

  factory Equipo.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Equipo(
      id: doc.id,
      userId: data['userId'],
      nombre: data['nombre'],
      descripcion: data['descripcion'],
      serial: data['serial'],
      modelo: data['modelo'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'nombre': nombre,
      'descripcion': descripcion,
      'serial': serial,
      'modelo': modelo,
    };
  }
  
  Equipo copyWith({
    String? id,
    String? userId,
    String? nombre,
    String? descripcion,
    String? serial,
    String? modelo,
  }) {
    return Equipo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      serial: serial ?? this.serial,
      modelo: modelo ?? this.modelo,
    );
  }
}
