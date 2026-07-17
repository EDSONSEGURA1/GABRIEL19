import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/jugador_model.dart';
import 'package:myapp/providers/auth_provider.dart';

class JugadorProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthProvider _authProvider;
  String? get _userId => _authProvider.user?.uid;

  JugadorProvider(this._authProvider);

  Stream<List<Jugador>> getJugadores(String clubId) {
    if (_userId == null) {
      return Stream.value([]);
    }
    return _firestore
        .collection('jugadores')
        .where('clubId', isEqualTo: clubId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Jugador.fromMap(doc.data(), doc.id))
            .toList());
  }

    Stream<List<Jugador>> get allJugadores {
    if (_userId == null) {
      return Stream.value([]);
    }
    return _firestore
        .collection('jugadores')
        .where('userId', isEqualTo: _userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Jugador.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> addJugador(Jugador jugador) async {
    if (_userId == null) return;
    final data = jugador.toMap();
    data['userId'] = _userId;
    await _firestore.collection('jugadores').add(data);
  }

  Future<void> updateJugador(Jugador jugador) async {
    if (_userId == null) return;
    final data = jugador.toMap();
    data['userId'] = _userId;
    await _firestore.collection('jugadores').doc(jugador.id).update(data);
  }

  Future<void> deleteJugador(String jugadorId) async {
    await _firestore.collection('jugadores').doc(jugadorId).delete();
  }
}
