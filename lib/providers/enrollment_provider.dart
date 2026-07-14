import 'package:flutter/foundation.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/repositories/repositories.dart';

class EnrollmentProvider with ChangeNotifier {
  final EnrollmentRepository _enrollmentRepository = EnrollmentRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Stream<List<EnrollmentModel>> get enrollmentsStream =>
      _enrollmentRepository.getEnrollmentsStream();

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> registerEnrollment(EnrollmentModel enrollment) async {
    _setLoading(true);
    try {
      await _enrollmentRepository.registerEnrollmentWithTransaction(enrollment);
      _setLoading(false);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error al registrar la inscripción: $e');
      }
      _setLoading(false);
      return false;
    }
  }
}
