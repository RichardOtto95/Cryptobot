import 'package:flutter_modular/flutter_modular.dart';
import 'package:cryptobot/app/modules/sign/sign_store.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/colors.dart';
import '../../shared/utilities.dart';

class SignPage extends StatefulWidget {
  final String title;
  const SignPage({Key? key, this.title = 'SignPage'}) : super(key: key);
  @override
  SignPageState createState() => SignPageState();
}

class SignPageState extends ModularState<SignPage, SignStore> {
  final _formKey = GlobalKey<FormState>();

  String phone = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: wXD(35, context)),
              margin: EdgeInsets.symmetric(
                horizontal: wXD(10, context),
                vertical: hXD(30, context),
              ),
              height: hXD(135, context),
              width: wXD(1066, context),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Color(0x30000000),
                    offset: Offset(0, 3),
                  ),
                ],
                color: Color(0xfffafafa),
              ),
              alignment: Alignment.centerLeft,
              child: SelectableText(
                'Bem vindo(a)!',
                style: textFamily(
                  color: primaryColor,
                  fontSize: hXD(28, context),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Spacer(flex: 4),
            Text(
              'Entrar',
              style: textFamily(
                color: primaryColor,
                fontSize: hXD(28, context),
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(flex: 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  'Telefone',
                  style: textFamily(
                    color: primaryColor,
                    fontSize: hXD(20, context),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  width: wXD(238, context, webSize: 80),
                  height: hXD(45, context),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: primaryColor,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(11)),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          offset: Offset(0, 3),
                          color: Color(0x30000000),
                        )
                      ],
                      color: const Color(0xfffafafa)),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      autofocus: true,
                      inputFormatters: [phoneMask],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      cursorColor: primaryColor,
                      style: textFamily(
                        color: primaryColor,
                        fontSize: hXD(20, context),
                      ),
                      decoration: InputDecoration.collapsed(
                        hintText: '(99)99999-9999',
                        hintStyle: textFamily(
                          color: const Color(0xff707070).withOpacity(.4),
                          fontSize: hXD(20, context),
                        ),
                      ),
                      onChanged: (text) {
                        phone = phoneMask.unmaskText(text);
                        store.phone = phoneMask.unmaskText(text);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        if (value.length < 11) {
                          return 'Campo incompleto';
                        }

                        return null;
                      },
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (_formKey.currentState!.validate()) {
                          if (store.phone == "") {
                            store.phone = phone;
                          }
                          print('store.start: ${store.timerSeconds}');
                          if (store.timerSeconds != 60 &&
                              store.timerSeconds != 0) {
                            Fluttertoast.showToast(
                                msg:
                                    "Aguarde ${store.timerSeconds} segundos para reenviar um novo código",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            store.verifyNumber(context);
                          }
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            if (store.timerSeconds != 60 && store.timerSeconds != 0)
              Text(
                "Aguarde ${store.timerSeconds} segundos para reenviar um novo código",
                style: textFamily(fontSize: 13, fontWeight: FontWeight.normal),
              ),
            const Spacer(),
            InkWell(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                if (_formKey.currentState!.validate()) {
                  if (store.phone == "") {
                    store.phone = phone;
                  }
                  print('store.start: ${store.timerSeconds}');
                  if (store.timerSeconds != 60 && store.timerSeconds != 0) {
                    Fluttertoast.showToast(
                        msg:
                            "Aguarde ${store.timerSeconds} segundos para reenviar um novo código",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    store.verifyNumber(context);
                  }
                }
              },
              child: Container(
                width: wXD(238, context, webSize: 80),
                height: hXD(45, context),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: primaryColor,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(11),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        offset: Offset(0, 3),
                        color: Color(0x30000000),
                      )
                    ],
                    color: primaryColor),
                child: Text(
                  'Continuar',
                  style: textFamily(
                    color: const Color(0xfffafafa),
                    fontSize: hXD(28, context),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const Spacer(flex: 11),
          ],
        ),
      ),
    );
  }
}
