import 'package:cloud_firestore/cloud_firestore.dart';

class Mantenimiento {
  final String? id;
  final String equipoId;
  final DateTime fecha;
  final String descripcion;

  Mantenimiento({
    this.id,
    required this.equipoId,
    required this.fecha,
    required this.descripcion,
  });

  factory Mantenimiento.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Mantenimiento(
      id: doc.id,
      equipoId: data['equipoId'],
      fecha: (data['fecha'] as Timestamp).toDate(),
      descripcion: data['descripcion'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'equipoId': equipoId,
      'fecha': Timestamp.fromDate(fecha),
      'descripcion': descripcion,
    };
  }
}
