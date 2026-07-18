import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// El Repositorio que maneja la lógica de negocio de la autenticación
class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);

  // Stream para escuchar los cambios de estado de autenticación
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Iniciar sesión con correo y contraseña
  Future<void> signInWithEmailAndPassword(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  // Registrar un nuevo usuario
  Future<UserCredential> createUserWithEmailAndPassword(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  // Cerrar sesión
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  // Obtener el usuario actual
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}

// Provider para la instancia de FirebaseAuth
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// Provider para exponer el AuthRepository a la UI
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(firebaseAuthProvider));
});

// Provider que expone el STREAM de cambios de autenticación
// La UI escuchará este provider para saber si el usuario ha iniciado/cerrado sesión
final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});
