// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignStore on _SignStoreBase, Store {
  final _$titlerAtom = Atom(name: '_SignStoreBase.titler');

  @override
  Title get titler {
    _$titlerAtom.reportRead();
    return super.titler;
  }

  @override
  set titler(Title value) {
    _$titlerAtom.reportWrite(value, super.titler, () {
      super.titler = value;
    });
  }

  final _$phoneAtom = Atom(name: '_SignStoreBase.phone');

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  final _$emailAtom = Atom(name: '_SignStoreBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$verificationCodeAtom = Atom(name: '_SignStoreBase.verificationCode');

  @override
  String get verificationCode {
    _$verificationCodeAtom.reportRead();
    return super.verificationCode;
  }

  @override
  set verificationCode(String value) {
    _$verificationCodeAtom.reportWrite(value, super.verificationCode, () {
      super.verificationCode = value;
    });
  }

  final _$timerSecondsAtom = Atom(name: '_SignStoreBase.timerSeconds');

  @override
  int get timerSeconds {
    _$timerSecondsAtom.reportRead();
    return super.timerSeconds;
  }

  @override
  set timerSeconds(int value) {
    _$timerSecondsAtom.reportWrite(value, super.timerSeconds, () {
      super.timerSeconds = value;
    });
  }

  final _$timerAtom = Atom(name: '_SignStoreBase.timer');

  @override
  Timer? get timer {
    _$timerAtom.reportRead();
    return super.timer;
  }

  @override
  set timer(Timer? value) {
    _$timerAtom.reportWrite(value, super.timer, () {
      super.timer = value;
    });
  }

  final _$confirmationResultAtom =
      Atom(name: '_SignStoreBase.confirmationResult');

  @override
  ConfirmationResult? get confirmationResult {
    _$confirmationResultAtom.reportRead();
    return super.confirmationResult;
  }

  @override
  set confirmationResult(ConfirmationResult? value) {
    _$confirmationResultAtom.reportWrite(value, super.confirmationResult, () {
      super.confirmationResult = value;
    });
  }

  final _$verifyNumberAsyncAction = AsyncAction('_SignStoreBase.verifyNumber');

  @override
  Future verifyNumber(BuildContext context) {
    return _$verifyNumberAsyncAction.run(() => super.verifyNumber(context));
  }

  final _$verifyCodeAsyncAction = AsyncAction('_SignStoreBase.verifyCode');

  @override
  Future<dynamic> verifyCode(dynamic context) {
    return _$verifyCodeAsyncAction.run(() => super.verifyCode(context));
  }

  final _$updateUserEmailAsyncAction =
      AsyncAction('_SignStoreBase.updateUserEmail');

  @override
  Future updateUserEmail(dynamic context) {
    return _$updateUserEmailAsyncAction
        .run(() => super.updateUserEmail(context));
  }

  @override
  String toString() {
    return '''
titler: ${titler},
phone: ${phone},
email: ${email},
verificationCode: ${verificationCode},
timerSeconds: ${timerSeconds},
timer: ${timer},
confirmationResult: ${confirmationResult}
    ''';
  }
}
