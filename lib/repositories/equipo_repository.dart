import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventarios_unap/models/equipo.dart';

class EquipoRepository {
  final FirebaseFirestore _firestore;

  EquipoRepository(this._firestore);

  Stream<List<Equipo>> getEquipos(String userId) {
    return _firestore
        .collection('equipos')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Equipo.fromFirestore(doc)).toList();
    });
  }

  Future<void> addEquipo(Equipo equipo) {
    return _firestore.collection('equipos').add(equipo.toFirestore());
  }

  Future<void> updateEquipo(Equipo equipo) {
    return _firestore.collection('equipos').doc(equipo.id).update(equipo.toFirestore());
  }

  Future<void> deleteEquipo(String equipoId) {
    return _firestore.collection('equipos').doc(equipoId).delete();
  }
}
