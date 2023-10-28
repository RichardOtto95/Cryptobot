import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptobot/app/modules/main/main_store.dart';
import 'package:cryptobot/app/shared/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store implements Disposable {
  final MainStore mainStore = Modular.get();
  final messagesKey = GlobalKey<AnimatedListState>();

  _HomeStoreBase() {
    final accountStream = FirebaseFirestore.instance
        .collection("users")
        .doc(mainStore.titled!.id)
        .collection("accounts")
        .doc(mainStore.titled!.mainAccount)
        .snapshots();

    subscriptionAccount = accountStream.listen((accountDoc) {
      account = accountDoc.data();
    });
  }

  @override
  void dispose() {
    if (subscriptionAccount != null) subscriptionAccount!.cancel();
  }

  @observable
  String text = "";
  @observable
  String procedure = "";
  @observable
  String receiverText = "";
  @observable
  String receiverSelected = "";
  @observable
  String procedureDescription = "";
  @observable
  double procedureValue = 0;
  @observable
  DateTime procedureDate = DateTime.now();
  @observable
  List<String> words = [];
  @observable
  Map<String, dynamic>? account;
  @observable
  StreamSubscription? subscriptionAccount;
  @observable
  TextEditingController textController = TextEditingController();
  @observable
  ObservableList<Map<String, dynamic>> messages =
      <Map<String, dynamic>>[].asObservable();
  @observable
  ObservableList<Map<String, dynamic>> operations =
      <Map<String, dynamic>>[].asObservable();

  @action
  onChanged(String value) {
    text = value;
    final _value = value.toLowerCase();
    words = _value.split(" ");
    // print("\n");
    // print("words: $words");
    if (words.contains("enviar")) {
      procedure = "BANK_TRANSFER";
      // print("procedure: $procedure");
      if (words.length > words.indexOf("enviar") + 1) {
        try {
          procedureValue = double.parse(words[words.indexOf("enviar") + 1]);
          // print("procedureValue: $procedureValue");
        } catch (e) {
          // print("Erro: $e");
        }
      }
    } else {
      procedure = "";
    }
    if (words.contains("para")) {
      // print("words.indexOf('para'): ${words.indexOf("para")} ");
      // print("words.length: ${words.length}");
      int toIndex = words.indexOf("para");
      if (words.length > toIndex + 1) {
        receiverText = words[toIndex + 1];
        // print("procedureReceiver: $procedureReceiver");
      }
    }
  }

  @action
  setProcedureReceiver(String _receiver) {
    if (receiverSelected == _receiver) {
      receiverSelected = "";
    } else {
      receiverSelected = _receiver;
    }
  }

  @action
  sendProcedure() async {
    if (procedure == "BANK_TRANSFER") {
      if (receiverSelected == "") {
        showToast("Selecione um destinatário para continuar");
        return;
      }
      List<String> newWords = textController.text.split(" ");
      int receiverIndex = newWords.indexOf("para") + 1;
      newWords[receiverIndex] = receiverSelected;
      String messageText = newWords.join(" ");
      messages.insert(messages.length, {
        "date": DateTime.now(),
        "text": messageText,
        "avatar": null,
        "author": "user",
        "type": "USER_MESSAGE",
        "status": "ACTIVE",
      });
      // print("messages.length: ${messages.length}");
      messagesKey.currentState!.insertItem(messages.length - 1,
          duration: const Duration(milliseconds: 400));
    }
    receiverText = "";
    textController.clear();
    await Future.delayed(const Duration(seconds: 2));
    messages.insert(messages.length, {
      "status": "BOT_WRITING",
    });
    messagesKey.currentState!.insertItem(messages.length - 1,
        duration: const Duration(milliseconds: 400));
    await Future.delayed(
        const Duration(seconds: 1), () => sendBankTransferConfirmProcedure());
  }

  @action
  sendBankTransferConfirmProcedure() async {
    procedure = "CONFIRM_BANK_TRANSFER";
    // print("procedureDate: $procedureDate");
    // print(procedureDate.toString().substring(0, 10));
    procedureDescription = "Transferência para $receiverSelected";
    messages.last = {
      "type": "CONFIRM_BANK_TRANSFER",
      "from": "Conta Principal",
      "to": receiverSelected,
      "amount": procedureValue,
      "date": DateTime.now(),
      "procedure_date": procedureDate,
      "text": "Estou pronto para fazer um novo pagamento",
      "description": procedureDescription,
    };
  }

  @action
  confirmBankTransfer() async {
    Map<String, dynamic> operation = {
      "date": Timestamp.fromDate(procedureDate),
      "created_at": Timestamp.now(),
      "value": procedureValue,
      "card_type": "VISA",
      "last_card_numbers": "3066",
      "sender": mainStore.authStore.user!.uid,
      "receiver": receiverSelected,
      "description": procedureDescription,
      "status": "SCHEDULED",
      "type": "BANK_TRANSFER",
    };
    // print("operation: $operation");
    // operations.add(operation);
    messages.insert(messages.length, {
      "status": "BOT_WRITING",
    });

    messagesKey.currentState!
        .insertItem(0, duration: const Duration(milliseconds: 300));

    final operationRef = await FirebaseFirestore.instance
        .collection("users")
        .doc(mainStore.authStore.user!.uid)
        .collection("historic")
        .add(operation);

    await operationRef.update({"created_at": FieldValue.serverTimestamp()});

    for (var i = messages.length - 1; i >= 0; i--) {
      messages.removeAt(i);
      messagesKey.currentState!
          .removeItem(i, (context, animation) => Container());
    }

    cleanBankTransferVars();

    messages.insert(
      0,
      {
        "date": DateTime.now(),
        "text":
            "Operação realizada com sucesso!\nNo que mais posso-lhe ser útil?",
        "avatar": null,
        "author": "bot",
        "type": "BOT_MESSAGE",
        "status": "ACTIVE",
      },
    );
    messagesKey.currentState!
        .insertItem(0, duration: const Duration(milliseconds: 300));
  }

  @action
  cancelOperation() {
    for (var i = messages.length - 1; i >= 0; i--) {
      messages.removeAt(i);
      messagesKey.currentState!
          .removeItem(i, (context, animation) => Container());
    }

    cleanBankTransferVars();

    messages.insert(
      0,
      {
        "date": DateTime.now(),
        "text": "No que posso te ajudar?",
        "avatar": null,
        "author": "bot",
        "type": "BOT_MESSAGE",
        "status": "ACTIVE",
      },
    );
    messagesKey.currentState!
        .insertItem(0, duration: const Duration(milliseconds: 300));
  }

  @action
  cleanBankTransferVars() {
    text = "";
    procedure = "";
    receiverText = "";
    receiverSelected = "";
    procedureDescription = "";
    procedureValue = 0;
    procedureDate = DateTime.now();
    words = [];
  }
}
