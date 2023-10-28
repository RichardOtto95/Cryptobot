import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptobot/app/core/models/titled_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';

import '../../core/services/auth/auth_service_interface.dart';
import '../../core/services/auth/auth_store.dart';
import '../../shared/utilities.dart';
import '../../shared/widgets/load_circular_overlay.dart';

part 'sign_store.g.dart';

class SignStore = _SignStoreBase with _$SignStore;

abstract class _SignStoreBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthStore authStore = Modular.get();
  final AuthServiceInterface authService = Modular.get();

  @observable
  late Title titler;
  @observable
  String phone = "";
  @observable
  String email = "";
  @observable
  String verificationCode = "";
  @observable
  int timerSeconds = 60;
  @observable
  Timer? timer;
  @observable
  ConfirmationResult? confirmationResult;

  @action
  verifyNumber(BuildContext context) async {
    authStore.overlayEntry =
        OverlayEntry(builder: (context) => const LoadCircularOverlay());
    Overlay.of(context)!.insert(authStore.overlayEntry!);
    authStore.canBack = false;

    print('##### phone $phone');
    String userPhone = '+55' + phone;
    print('##### userPhone $userPhone');

    confirmationResult = await _auth.signInWithPhoneNumber(userPhone);

    authStore.overlayEntry!.remove();
    authStore.overlayEntry = null;

    await Modular.to.pushNamed("/sign/verify");

    // await authStore.verifyNumber(phone);
  }

  @action
  Future verifyCode(context) async {
    authStore.overlayEntry =
        OverlayEntry(builder: (context) => const LoadCircularOverlay());
    Overlay.of(context)!.insert(authStore.overlayEntry!);
    print(
        'resulConfirm.verificationId ==========1: ${confirmationResult!.verificationId}');
    print('code: $verificationCode');
    if (verificationCode.length != 6) {
      Fluttertoast.showToast(
          msg: "Digite o código corretamente",
          webPosition: 'center',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          webBgColor: "linear-gradient(to bottom, #DD1919, #DD1919)",
          textColor: Colors.white,
          fontSize: 16.0);
      authStore.overlayEntry!.remove();
      authStore.overlayEntry = null;
    } else {
      try {
        UserCredential userCredential =
            await confirmationResult!.confirm(verificationCode);
        User user = userCredential.user!;
        print("CurrentUser: ${FirebaseAuth.instance.currentUser}");
        print('userCredential: $userCredential');
        print('_auth.currentUser ==========2: ${_auth.currentUser}');
        print('### user: $user');
        print('### user: ${user.phoneNumber}');
        final userRef =
            FirebaseFirestore.instance.collection("users").doc(user.uid);
        final userDoc = await userRef.get();
        if (!userDoc.exists) {
          await userRef.set(Titled(
            id: userRef.id,
            username: user.phoneNumber,
            phone: user.phoneNumber,
          ).toJson());
          await userRef.update({"created_at": FieldValue.serverTimestamp()});
        }
        phone == "";
        Modular.to.pushNamed("/main");
        authStore.overlayEntry!.remove();
        authStore.overlayEntry = null;
      } on FirebaseAuthException catch (e) {
        print('Failed with error code: ${e.code}');
        switch (e.code) {
          case 'invalid-verification-code':
            authStore.overlayEntry!.remove();
            authStore.overlayEntry = null;
            return Fluttertoast.showToast(
                msg: "Código inválido",
                webPosition: 'center',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                webBgColor: "linear-gradient(to bottom, #DD1919, #DD1919)",
                textColor: Colors.white,
                fontSize: 16.0);
          default:
            authStore.overlayEntry!.remove();
            authStore.overlayEntry = null;
            print('Case of ${e.code} not defined');
        }
      }
    }
  }

  @action
  updateUserEmail(context) async {
    OverlayEntry overlayEntry =
        OverlayEntry(builder: (context) => const LoadCircularOverlay());
    Overlay.of(context)!.insert(overlayEntry);

    print('updateUserPhone');
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await _auth.currentUser!.updateEmail(email);
      await authService.handleSignup(titler);
      Modular.to.pushNamed('/main', arguments: true);
      print('email atualizado!!!');
    } on FirebaseAuthException catch (error) {
      print('erro ao atualizar!!!');
      print(error);
      print(error.code);

      if (error.code == 'email-already-in-use') {
        showToast('O e-mail digitado já está em uso!');
      }
      if (error.code == 'invalid-email') {
        showToast('E-mail inválido!');
      }
    }

    overlayEntry.remove();
  }
}
