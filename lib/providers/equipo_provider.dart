import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventarios_unap/models/equipo.dart';
import 'package:inventarios_unap/repositories/equipo_repository.dart';
import 'package:inventarios_unap/providers/auth_provider.dart';

// Provider para el repositorio, para que pueda ser inyectado y mockeado.
final equipoRepositoryProvider = Provider<EquipoRepository>((ref) {
  return EquipoRepository();
});

// El Notifier que gestiona el estado de la lista de equipos.
class EquiposNotifier extends StateNotifier<AsyncValue<List<Equipo>>> {
  final Ref _ref;
  StreamSubscription? _equiposSubscription;

  EquiposNotifier(this._ref) : super(const AsyncValue.loading()) {
    // Escucha el estado de autenticación. Si el usuario cambia, se actualiza la lista.
    _ref.listen(authStateProvider, (previous, next) {
      final user = next.asData?.value;
      if (user != null) {
        _listenToEquipos(user.uid);
      } else {
        state = const AsyncValue.data([]); // Si no hay usuario, la lista está vacía.
      }
    }, fireImmediately: true);
  }

  void _listenToEquipos(String userId) {
    _equiposSubscription?.cancel();
    final repository = _ref.read(equipoRepositoryProvider);
    _equiposSubscription = repository.getEquiposStream(userId).listen(
          (equipos) => state = AsyncValue.data(equipos),
          onError: (error, stack) => state = AsyncValue.error(error, stack),
        );
  }

  Future<void> addEquipo(Equipo equipo) async {
    final repository = _ref.read(equipoRepositoryProvider);
    try {
      await repository.addEquipo(equipo);
    } catch (e) {
      // Opcional: Manejar el error, por ejemplo, mostrar una notificación.
    }
  }

  Future<void> updateEquipo(Equipo equipo) async {
    final repository = _ref.read(equipoRepositoryProvider);
    try {
      await repository.updateEquipo(equipo);
    } catch (e) {
      // Opcional: Manejar el error.
    }
  }

  Future<void> deleteEquipo(String id) async {
    final repository = _ref.read(equipoRepositoryProvider);
    try {
      await repository.deleteEquipo(id);
    } catch (e) {
      // Opcional: Manejar el error.
    }
  }

  @override
  void dispose() {
    _equiposSubscription?.cancel();
    super.dispose();
  }
}

// El provider principal que las vistas consumirán.
final equiposProvider = StateNotifierProvider<EquiposNotifier, AsyncValue<List<Equipo>>>((ref) {
  return EquiposNotifier(ref);
});
