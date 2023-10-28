import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptobot/app/modules/main/main_store.dart';
import 'package:cryptobot/app/shared/widgets/load_circular_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStoreBase with _$SettingsStore;

abstract class _SettingsStoreBase with Store {
  final MainStore mainStore = Modular.get();

  @observable
  ObservableMap<String, dynamic> editTitled =
      <String, dynamic>{}.asObservable();

  @action
  Future updateTitled(context) async {
    final loadOverlay = OverlayEntry(
      builder: (context) => const LoadCircularOverlay(),
    );
    Overlay.of(context)!.insert(loadOverlay);
    Map<String, dynamic> _editTitled = editTitled;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(mainStore.authStore.user!.uid)
        .update(_editTitled);
    editTitled.clear();
    loadOverlay.remove();
  }
}
