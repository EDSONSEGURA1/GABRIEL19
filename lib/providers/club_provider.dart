import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/club_model.dart';

class ClubProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _userId;

  void setUserId(String? userId) {
    _userId = userId;
    notifyListeners();
  }

  Stream<List<Club>> get clubs {
    if (_userId == null) {
      return Stream.value([]);
    }
    return _firestore
        .collection('clubs')
        .where('userId', isEqualTo: _userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Club.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> addClub(Club club) async {
    if (_userId == null) return;
    await _firestore.collection('clubs').add(club.toMap(_userId!));
  }

  Future<void> updateClub(Club club) async {
    await _firestore.collection('clubs').doc(club.id).update(club.toMap(_userId!));
  }

  Future<void> deleteClub(String clubId) async {
    await _firestore.collection('clubs').doc(clubId).delete();
  }
}
