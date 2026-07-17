import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/fichaje_model.dart';
import 'package:myapp/models/jugador_model.dart';
import 'package:myapp/providers/auth_provider.dart';

class FichajeProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthProvider _authProvider;
  String? get _userId => _authProvider.user?.uid;


  FichajeProvider(this._authProvider);

  Stream<List<Fichaje>> get historialFichajes {
     if (_userId == null) {
      return Stream.value([]);
    }
    return _firestore
        .collection('fichajes')
        .where('userId', isEqualTo: _userId)
        .orderBy('fecha', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Fichaje.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Future<void> ficharJugador(
    Jugador jugador,
    String clubDestinoId,
    String nombreClubDestino,
  ) async {
    if (_userId == null) return;

    final nuevoFichaje = Fichaje(
      id: '',
      jugadorId: jugador.id,
      nombreJugador: jugador.nombre,
      clubOrigenId: jugador.clubId,
      nombreClubOrigen: jugador.nombreClub,
      clubDestinoId: clubDestinoId,
      nombreClubDestino: nombreClubDestino,
      fecha: DateTime.now(),
    );

    WriteBatch batch = _firestore.batch();

    final fichajeRef = _firestore.collection('fichajes').doc();
    final data = nuevoFichaje.toMap();
    data['userId'] = _userId;
    batch.set(fichajeRef, data);

    final jugadorRef = _firestore.collection('jugadores').doc(jugador.id);
    batch.update(jugadorRef, {
      'clubId': clubDestinoId,
      'nombreClub': nombreClubDestino,
    });

    await batch.commit();

  }
}
