import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptobot/app/constants/colors.dart';
import 'package:cryptobot/app/core/models/time_model.dart';
import 'package:cryptobot/app/modules/main/main_store.dart';
import 'package:cryptobot/app/shared/utilities.dart';
import 'package:cryptobot/app/shared/widgets/crypto_tilte.dart';
import 'package:cryptobot/app/shared/widgets/data_field.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cryptobot/app/modules/settings/settings_store.dart';
import 'package:flutter/material.dart';

import '../../core/models/titled_model.dart';

class SettingsPage extends StatefulWidget {
  final String title;
  const SettingsPage({Key? key, this.title = 'SettingsPage'}) : super(key: key);
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final MainStore mainStore = Modular.get();
  final SettingsStore store = Modular.get();

  final FocusNode fullnameFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode birthdayFocus = FocusNode();
  final FocusNode cpfFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  String password = "";
  String confirmPassword = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backGroundPrimaryColor,
      height: maxHeight(context),
      width: maxWidth(context),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CryptoTitle("Configurações"),
            Container(
              width: maxWidth(context),
              // height: maxHeight(context),
              decoration: const BoxDecoration(
                  color: backGroundPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  boxShadow: [
                    BoxShadow(
                      color: shadow,
                      blurRadius: 4,
                    ),
                  ]),
              margin: EdgeInsets.fromLTRB(
                wXD(10, context, webSize: 100),
                wXD(0, context),
                wXD(10, context, webSize: 30),
                wXD(10, context),
              ),
              padding: EdgeInsets.fromLTRB(
                wXD(10, context, webSize: 55),
                wXD(10, context, webHeight: 25),
                wXD(10, context),
                wXD(10, context),
              ),
              child: Observer(builder: (context) {
                Titled titled = mainStore.titled!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CryptoTitle(
                      "Informações gerais",
                      webLeft: 0,
                      webTop: 5,
                    ),
                    SizedBox(
                      width: maxWidth(context),
                      child: Wrap(
                        children: [
                          DataField(
                            "Nome completo",
                            initialValue: titled.fullname,
                            focusNode: fullnameFocus,
                            onChanged: (val) =>
                                store.editTitled["fullname"] = val,
                            onEditionComplete: () =>
                                usernameFocus.requestFocus(),
                          ),
                          DataField(
                            "Nome de usuário",
                            right: 0,
                            initialValue: titled.username,
                            focusNode: usernameFocus,
                            onChanged: (val) =>
                                store.editTitled["username"] = val,
                            onEditionComplete: () =>
                                birthdayFocus.requestFocus(),
                          ),
                          DataField(
                            "Nascimento",
                            initialValue: titled.birthday != null
                                ? Time(titled.birthday!.toDate()).dayDate()
                                : store.editTitled.containsKey("birthday")
                                    ? Time(store.editTitled["birthday"]
                                            .toDate())
                                        .dayDate()
                                    : null,
                            focusNode: birthdayFocus,
                            onTap: () => pickDate(context, onConfirm: (_date) {
                              if (_date != null) {
                                store.editTitled["birthday"] =
                                    Timestamp.fromDate(_date);
                              }
                            }),
                          ),
                          DataField(
                            "CPF",
                            right: 0,
                            initialValue: titled.cpf != null
                                ? cpfMask.maskText(titled.cpf!)
                                : null,
                            focusNode: cpfFocus,
                            onChanged: (val) => store.editTitled["cpf"] = val,
                            onEditionComplete: () => emailFocus.requestFocus(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: wXD(10, context, webSize: 7)),
                    DataField(
                      "Email",
                      initialValue: titled.email,
                      focusNode: emailFocus,
                      onChanged: (val) => store.editTitled["email"] = val,
                      onEditionComplete: () => passwordFocus.requestFocus(),
                    ),
                    SizedBox(
                      width: maxWidth(context),
                      child: Wrap(
                        children: [
                          DataField(
                            "Senha",
                            focusNode: passwordFocus,
                            onChanged: (val) => password = val,
                            onEditionComplete: () =>
                                confirmPasswordFocus.requestFocus(),
                          ),
                          DataField(
                            "Confirmar senha",
                            right: 0,
                            focusNode: confirmPasswordFocus,
                            onChanged: (val) => confirmPassword = val,
                            onEditionComplete: () =>
                                confirmPasswordFocus.unfocus(),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: wXD(40, context, webHeight: 70),
                        width: wXD(80, context, webSize: 120),
                        decoration: const BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        alignment: Alignment.center,
                        child: Text(
                          "Salvar",
                          style: textFamily(),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
