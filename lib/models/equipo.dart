import 'package:cloud_firestore/cloud_firestore.dart';

// Este modelo ahora representa un Equipo Deportivo
class Equipo {
  final String? id;
  final String userId; // El usuario que crea el equipo
  final String nombre; // Nombre del equipo deportivo
  final String? descripcion; // Descripción o notas sobre el equipo
  final String? categoria; // Categoría para filtrar (ej: Liga A, Amistoso)

  Equipo({
    this.id,
    required this.userId,
    required this.nombre,
    this.descripcion,
    this.categoria,
  });

  factory Equipo.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Equipo(
      id: doc.id,
      userId: data['userId'],
      nombre: data['nombre'],
      descripcion: data['descripcion'],
      categoria: data['categoria'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'nombre': nombre,
      'descripcion': descripcion,
      'categoria': categoria,
    };
  }

  Equipo copyWith({
    String? id,
    String? userId,
    String? nombre,
    String? descripcion,
    String? categoria,
  }) {
    return Equipo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      categoria: categoria ?? this.categoria,
    );
  }
}
