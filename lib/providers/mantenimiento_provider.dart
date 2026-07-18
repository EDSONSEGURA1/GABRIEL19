import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventarios_unap/models/mantenimiento.dart';
import 'package:inventarios_unap/repositories/mantenimiento_repository.dart';

final mantenimientoRepositoryProvider = Provider<MantenimientoRepository>(
  (ref) => MantenimientoRepository(FirebaseFirestore.instance),
);

class MantenimientosNotifier extends StateNotifier<AsyncValue<List<Mantenimiento>>> {
  final Ref _ref;
  StreamSubscription? _subscription;

  MantenimientosNotifier(this._ref) : super(const AsyncValue.loading());

  void getMantenimientos(String equipoId) {
    _subscription?.cancel();
    final repository = _ref.read(mantenimientoRepositoryProvider);
    _subscription = repository.getMantenimientos(equipoId).listen(
          (data) => state = AsyncValue.data(data),
          onError: (error, stack) => state = AsyncValue.error(error, stack),
        );
  }

  Future<void> addMantenimiento(Mantenimiento mantenimiento) async {
    await _ref.read(mantenimientoRepositoryProvider).addMantenimiento(mantenimiento);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

final mantenimientosProvider =
    StateNotifierProvider.family<MantenimientosNotifier, AsyncValue<List<Mantenimiento>>, String>(
  (ref, equipoId) {
    final notifier = MantenimientosNotifier(ref);
    notifier.getMantenimientos(equipoId);
    return notifier;
  },
);
