import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventarios_unap/models/equipo.dart';
import 'package:inventarios_unap/repositories/equipo_repository.dart';
import 'package:inventarios_unap/providers/auth_provider.dart';

final equipoRepositoryProvider = Provider<EquipoRepository>(
  (ref) => EquipoRepository(FirebaseFirestore.instance),
);

class EquiposNotifier extends StateNotifier<AsyncValue<List<Equipo>>> {
  final Ref _ref;
  StreamSubscription? _equiposSubscription;

  EquiposNotifier(this._ref) : super(const AsyncValue.loading()) {
    final user = _ref.watch(authStateProvider).asData?.value;
    if (user != null) {
      _listenToEquipos(user.uid);
    } else {
      state = const AsyncValue.data([]);
    }
  }

  void _listenToEquipos(String userId) {
    _equiposSubscription?.cancel();
    final repository = _ref.read(equipoRepositoryProvider);
    _equiposSubscription = repository.getEquipos(userId).listen(
          (equipos) => state = AsyncValue.data(equipos),
          onError: (error, stack) => state = AsyncValue.error(error, stack),
        );
  }

  Future<void> addEquipo(Equipo equipo) async {
    final user = _ref.read(authStateProvider).asData?.value;
    if (user == null) throw Exception('User not authenticated');
    await _ref.read(equipoRepositoryProvider).addEquipo(equipo.copyWith(userId: user.uid));
  }

  Future<void> updateEquipo(Equipo equipo) async {
    await _ref.read(equipoRepositoryProvider).updateEquipo(equipo);
  }

  Future<void> deleteEquipo(String id) async {
    await _ref.read(equipoRepositoryProvider).deleteEquipo(id);
  }

  @override
  void dispose() {
    _equiposSubscription?.cancel();
    super.dispose();
  }
}

final equiposProvider =
    StateNotifierProvider<EquiposNotifier, AsyncValue<List<Equipo>>>(
  (ref) => EquiposNotifier(ref),
);
