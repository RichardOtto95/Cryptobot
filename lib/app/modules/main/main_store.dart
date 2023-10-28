import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptobot/app/core/services/auth/auth_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/models/titled_model.dart';

part 'main_store.g.dart';

class MainStore = _MainStoreBase with _$MainStore;

abstract class _MainStoreBase with Store implements Disposable {
  final AuthStore authStore = Modular.get();

  _MainStoreBase() {
    print(
        "FirebaseAuth.instance.currentUser: ${FirebaseAuth.instance.currentUser}");
    authStore.setUser(FirebaseAuth.instance.currentUser);
    // print("authStore.user: ${authStore.user}");
    if (authStore.user != null) {
      final userStream = FirebaseFirestore.instance
          .collection("users")
          .doc(authStore.user!.uid)
          .snapshots();

      userSubscription = userStream.listen((userDoc) {
        titled = Titled.fromDoc(userDoc);
      });
    }
  }

  @override
  void dispose() {
    if (userSubscription != null) userSubscription!.cancel();
  }

  StreamSubscription? userSubscription;

  @observable
  Titled? titled;
  @observable
  int page = 1;
}
