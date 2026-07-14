import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/models.dart';

class EnrollmentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _enrollmentsCollection;
  late final CollectionReference _subjectsCollection;

  EnrollmentRepository() {
    _enrollmentsCollection = _firestore.collection('enrollments');
    _subjectsCollection = _firestore.collection('subjects'); // Referencia a la colección de materias
  }

  Future<void> registerEnrollmentWithTransaction(
    EnrollmentModel enrollment,
  ) async {
    try {
      await _firestore.runTransaction((transaction) async {
        // 1. VERIFICAR QUE EL ALUMNO NO ESTÉ INSCRITO YA
        final querySnapshot = await _enrollmentsCollection
            .where('studentId', isEqualTo: enrollment.studentId)
            .where('subjectId', isEqualTo: enrollment.subjectId)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          throw Exception('El alumno ya se encuentra inscrito en esta materia.');
        }

        // 2. OBTENER EL DOCUMENTO DE LA MATERIA PARA VERIFICAR CUPOS
        final subjectRef = _subjectsCollection.doc(enrollment.subjectId);
        final subjectDoc = await transaction.get(subjectRef);

        if (!subjectDoc.exists) {
          throw Exception('La materia seleccionada no existe.');
        }

        final subjectData = subjectDoc.data() as Map<String, dynamic>?;
        final availableSlots = subjectData?['availableSlots'] as int? ?? 0;

        if (availableSlots <= 0) {
          throw Exception('No hay cupos disponibles para esta materia.');
        }

        // 3. CREAR LA NUEVA INSCRIPCIÓN (ASIGNACIÓN)
        final newEnrollmentRef = _enrollmentsCollection.doc();
        transaction.set(newEnrollmentRef, enrollment.toFirestore());

        // 4. ACTUALIZAR EL DOCUMENTO DE LA MATERIA, RESTANDO UN CUPO
        // Esta es la segunda actualización que pedía el profesor.
        transaction.update(subjectRef, {
          'availableSlots': FieldValue.increment(-1),
        });
      });
    } catch (e) {
      // Re-lanzar la excepción para que sea manejada por el Provider/UI
      rethrow;
    }
  }

  Stream<List<EnrollmentModel>> getEnrollmentsStream() {
    return _enrollmentsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .where((doc) => doc.exists && doc.data() != null)
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return EnrollmentModel.fromFirestore(doc.id, data);
          })
          .toList();
    });
  }
}
