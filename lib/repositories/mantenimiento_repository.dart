import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventarios_unap/models/mantenimiento.dart';

class MantenimientoRepository {
  final FirebaseFirestore _firestore;

  MantenimientoRepository(this._firestore);

  Stream<List<Mantenimiento>> getMantenimientos(String equipoId) {
    return _firestore
        .collection('equipos')
        .doc(equipoId)
        .collection('mantenimientos')
        .orderBy('fecha', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Mantenimiento.fromFirestore(doc)).toList();
    });
  }

  Future<void> addMantenimiento(Mantenimiento mantenimiento) {
    return _firestore
        .collection('equipos')
        .doc(mantenimiento.equipoId)
        .collection('mantenimientos')
        .add(mantenimiento.toFirestore());
  }
}
