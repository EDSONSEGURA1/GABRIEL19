import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventarios_unap/models/equipo.dart';
import 'package:inventarios_unap/repositories/equipo_repository.dart';
import 'package:inventarios_unap/providers/auth_provider.dart';

final equipoRepositoryProvider = Provider<EquipoRepository>((ref) {
  return EquipoRepository();
});

class EquiposNotifier extends StateNotifier<AsyncValue<List<Equipo>>> {
  final Ref _ref;
  StreamSubscription? _equiposSubscription;

  EquiposNotifier(this._ref) : super(const AsyncValue.loading()) {
    _ref.listen(authStateChangesProvider, (previous, next) {
      final user = next.asData?.value;
      if (user != null) {
        _listenToEquipos(user.uid);
      } else {
        state = const AsyncValue.data([]);
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
    final user = _ref.read(authRepositoryProvider).getCurrentUser();
    if (user != null) {
      await repository.addEquipo(equipo.copyWith(userId: user.uid));
    }
  }

  Future<void> updateEquipo(Equipo equipo) async {
    final repository = _ref.read(equipoRepositoryProvider);
    await repository.updateEquipo(equipo);
  }

  Future<void> deleteEquipo(String id) async {
    final repository = _ref.read(equipoRepositoryProvider);
    await repository.deleteEquipo(id);
  }

  @override
  void dispose() {
    _equiposSubscription?.cancel();
    super.dispose();
  }
}

final equiposProvider = StateNotifierProvider<EquiposNotifier, AsyncValue<List<Equipo>>>((ref) {
  return EquiposNotifier(ref);
});
