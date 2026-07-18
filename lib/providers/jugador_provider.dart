import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventarios_unap/data/jugador_repository.dart';
import 'package:inventarios_unap/models/jugador.dart';

// 1. Provider para el Repositorio
final jugadorRepositoryProvider = Provider<JugadorRepository>((ref) {
  return JugadorRepository();
});

// 2. Provider para el Stream de jugadores
final jugadoresStreamProvider = StreamProvider<List<Jugador>>((ref) {
  final repository = ref.watch(jugadorRepositoryProvider);
  return repository.getJugadoresStream();
});

// 3. StateNotifier para manejar la lógica de negocio (añadir, editar, borrar)
class JugadoresNotifier extends StateNotifier<AsyncValue<List<Jugador>>> {
  final JugadorRepository _repository;
  StreamSubscription<List<Jugador>>? _subscription;

  JugadoresNotifier(this._repository) : super(const AsyncValue.loading()) {
    _listenToJugadores();
  }

  void _listenToJugadores() {
    _subscription?.cancel();
    _subscription = _repository.getJugadoresStream().listen(
          (jugadores) => state = AsyncValue.data(jugadores),
          onError: (error, stack) => state = AsyncValue.error(error, stack),
        );
  }

  Future<void> addJugador(Jugador jugador) async {
    try {
      await _repository.addJugador(jugador);
    } catch (e) {
      // Manejo de errores si es necesario
    }
  }

  Future<void> updateJugador(Jugador jugador) async {
    try {
      await _repository.updateJugador(jugador);
    } catch (e) {
      // Manejo de errores
    }
  }

  Future<void> deleteJugador(String jugadorId) async {
    try {
      await _repository.deleteJugador(jugadorId);
    } catch (e) {
      // Manejo de errores
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

// 4. Provider principal para la lista de jugadores y sus operaciones
final jugadoresProvider = StateNotifierProvider<JugadoresNotifier, AsyncValue<List<Jugador>>>((ref) {
  final repository = ref.watch(jugadorRepositoryProvider);
  return JugadoresNotifier(repository);
});
