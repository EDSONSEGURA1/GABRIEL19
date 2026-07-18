import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventarios_unap/models/jugador.dart';

class JugadorRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Obtiene un stream de la lista de jugadores del usuario actual
  Stream<List<Jugador>> getJugadoresStream() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      return Stream.value([]); // Devuelve un stream vacío si no hay usuario
    }
    return _firestore
        .collection('jugadores')
        .where('userId', isEqualTo: userId)
        .withConverter<Jugador>(
          fromFirestore: Jugador.fromFirestore,
          toFirestore: (jugador, _) => jugador.toFirestore(),
        )
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // Añade un nuevo jugador a Firestore
  Future<void> addJugador(Jugador jugador) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('Usuario no autenticado');
    }
    await _firestore.collection('jugadores').add(jugador.copyWith(userId: userId).toFirestore());
  }

  // Actualiza un jugador existente en Firestore
  Future<void> updateJugador(Jugador jugador) async {
    if (jugador.id == null) {
      throw Exception('El ID del jugador no puede ser nulo al actualizar');
    }
    await _firestore.collection('jugadores').doc(jugador.id).update(jugador.toFirestore());
  }

  // Elimina un jugador de Firestore
  Future<void> deleteJugador(String jugadorId) async {
    await _firestore.collection('jugadores').doc(jugadorId).delete();
  }
}
