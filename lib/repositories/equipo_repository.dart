import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventarios_unap/models/equipo.dart';

class EquipoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener un stream de equipos para un usuario específico
  Stream<List<Equipo>> getEquiposStream(String userId) {
    return _firestore
        .collection('equipos')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Equipo.fromFirestore(doc)).toList();
    });
  }

  // Añadir un nuevo equipo
  Future<void> addEquipo(Equipo equipo) async {
    await _firestore.collection('equipos').add(equipo.toFirestore());
  }

  // Actualizar un equipo existente
  Future<void> updateEquipo(Equipo equipo) async {
    await _firestore.collection('equipos').doc(equipo.id).update(equipo.toFirestore());
  }

  // Eliminar un equipo
  Future<void> deleteEquipo(String equipoId) async {
    await _firestore.collection('equipos').doc(equipoId).delete();
  }
}
