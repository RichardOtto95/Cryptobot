// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStoreBase, Store {
  final _$textAtom = Atom(name: '_HomeStoreBase.text');

  @override
  String get text {
    _$textAtom.reportRead();
    return super.text;
  }

  @override
  set text(String value) {
    _$textAtom.reportWrite(value, super.text, () {
      super.text = value;
    });
  }

  final _$procedureAtom = Atom(name: '_HomeStoreBase.procedure');

  @override
  String get procedure {
    _$procedureAtom.reportRead();
    return super.procedure;
  }

  @override
  set procedure(String value) {
    _$procedureAtom.reportWrite(value, super.procedure, () {
      super.procedure = value;
    });
  }

  final _$receiverTextAtom = Atom(name: '_HomeStoreBase.receiverText');

  @override
  String get receiverText {
    _$receiverTextAtom.reportRead();
    return super.receiverText;
  }

  @override
  set receiverText(String value) {
    _$receiverTextAtom.reportWrite(value, super.receiverText, () {
      super.receiverText = value;
    });
  }

  final _$receiverSelectedAtom = Atom(name: '_HomeStoreBase.receiverSelected');

  @override
  String get receiverSelected {
    _$receiverSelectedAtom.reportRead();
    return super.receiverSelected;
  }

  @override
  set receiverSelected(String value) {
    _$receiverSelectedAtom.reportWrite(value, super.receiverSelected, () {
      super.receiverSelected = value;
    });
  }

  final _$procedureDescriptionAtom =
      Atom(name: '_HomeStoreBase.procedureDescription');

  @override
  String get procedureDescription {
    _$procedureDescriptionAtom.reportRead();
    return super.procedureDescription;
  }

  @override
  set procedureDescription(String value) {
    _$procedureDescriptionAtom.reportWrite(value, super.procedureDescription,
        () {
      super.procedureDescription = value;
    });
  }

  final _$procedureValueAtom = Atom(name: '_HomeStoreBase.procedureValue');

  @override
  double get procedureValue {
    _$procedureValueAtom.reportRead();
    return super.procedureValue;
  }

  @override
  set procedureValue(double value) {
    _$procedureValueAtom.reportWrite(value, super.procedureValue, () {
      super.procedureValue = value;
    });
  }

  final _$procedureDateAtom = Atom(name: '_HomeStoreBase.procedureDate');

  @override
  DateTime get procedureDate {
    _$procedureDateAtom.reportRead();
    return super.procedureDate;
  }

  @override
  set procedureDate(DateTime value) {
    _$procedureDateAtom.reportWrite(value, super.procedureDate, () {
      super.procedureDate = value;
    });
  }

  final _$wordsAtom = Atom(name: '_HomeStoreBase.words');

  @override
  List<String> get words {
    _$wordsAtom.reportRead();
    return super.words;
  }

  @override
  set words(List<String> value) {
    _$wordsAtom.reportWrite(value, super.words, () {
      super.words = value;
    });
  }

  final _$accountAtom = Atom(name: '_HomeStoreBase.account');

  @override
  Map<String, dynamic>? get account {
    _$accountAtom.reportRead();
    return super.account;
  }

  @override
  set account(Map<String, dynamic>? value) {
    _$accountAtom.reportWrite(value, super.account, () {
      super.account = value;
    });
  }

  final _$subscriptionAccountAtom =
      Atom(name: '_HomeStoreBase.subscriptionAccount');

  @override
  StreamSubscription<dynamic>? get subscriptionAccount {
    _$subscriptionAccountAtom.reportRead();
    return super.subscriptionAccount;
  }

  @override
  set subscriptionAccount(StreamSubscription<dynamic>? value) {
    _$subscriptionAccountAtom.reportWrite(value, super.subscriptionAccount, () {
      super.subscriptionAccount = value;
    });
  }

  final _$textControllerAtom = Atom(name: '_HomeStoreBase.textController');

  @override
  TextEditingController get textController {
    _$textControllerAtom.reportRead();
    return super.textController;
  }

  @override
  set textController(TextEditingController value) {
    _$textControllerAtom.reportWrite(value, super.textController, () {
      super.textController = value;
    });
  }

  final _$messagesAtom = Atom(name: '_HomeStoreBase.messages');

  @override
  ObservableList<Map<String, dynamic>> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(ObservableList<Map<String, dynamic>> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  final _$operationsAtom = Atom(name: '_HomeStoreBase.operations');

  @override
  ObservableList<Map<String, dynamic>> get operations {
    _$operationsAtom.reportRead();
    return super.operations;
  }

  @override
  set operations(ObservableList<Map<String, dynamic>> value) {
    _$operationsAtom.reportWrite(value, super.operations, () {
      super.operations = value;
    });
  }

  final _$sendProcedureAsyncAction =
      AsyncAction('_HomeStoreBase.sendProcedure');

  @override
  Future sendProcedure() {
    return _$sendProcedureAsyncAction.run(() => super.sendProcedure());
  }

  final _$sendBankTransferConfirmProcedureAsyncAction =
      AsyncAction('_HomeStoreBase.sendBankTransferConfirmProcedure');

  @override
  Future sendBankTransferConfirmProcedure() {
    return _$sendBankTransferConfirmProcedureAsyncAction
        .run(() => super.sendBankTransferConfirmProcedure());
  }

  final _$confirmBankTransferAsyncAction =
      AsyncAction('_HomeStoreBase.confirmBankTransfer');

  @override
  Future confirmBankTransfer() {
    return _$confirmBankTransferAsyncAction
        .run(() => super.confirmBankTransfer());
  }

  final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase');

  @override
  dynamic onChanged(String value) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.onChanged');
    try {
      return super.onChanged(value);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setProcedureReceiver(String _receiver) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.setProcedureReceiver');
    try {
      return super.setProcedureReceiver(_receiver);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cancelOperation() {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.cancelOperation');
    try {
      return super.cancelOperation();
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cleanBankTransferVars() {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.cleanBankTransferVars');
    try {
      return super.cleanBankTransferVars();
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
text: ${text},
procedure: ${procedure},
receiverText: ${receiverText},
receiverSelected: ${receiverSelected},
procedureDescription: ${procedureDescription},
procedureValue: ${procedureValue},
procedureDate: ${procedureDate},
words: ${words},
account: ${account},
subscriptionAccount: ${subscriptionAccount},
textController: ${textController},
messages: ${messages},
operations: ${operations}
    ''';
  }
}
