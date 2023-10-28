import 'package:cryptobot/app/modules/sign/sign_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants/colors.dart';
import '../../../shared/utilities.dart';

class SignEmailPage extends StatefulWidget {
  const SignEmailPage({Key? key}) : super(key: key);

  @override
  _SignEmailPageState createState() => _SignEmailPageState();
}

class _SignEmailPageState extends ModularState<SignEmailPage, SignStore> {
  final _formKey = GlobalKey<FormState>();

  String phone = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Falta pouco, cadastre seu e-mail para concluir',
              style: textFamily(
                color: primaryColor,
                fontSize: hXD(28, context),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Spacer(flex: 4),
          Text(
            'Cadastro de e-mail',
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
                'E-mail',
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
                    textAlign: TextAlign.center,
                    cursorColor: primaryColor,
                    style: textFamily(
                      color: primaryColor,
                      fontSize: hXD(20, context),
                    ),
                    decoration: InputDecoration.collapsed(
                      hintText: 'exemplo@email.com',
                      hintStyle: textFamily(
                        color: const Color(0xff707070).withOpacity(.4),
                        fontSize: hXD(20, context),
                      ),
                    ),
                    initialValue: store.email,
                    onChanged: (text) => store.email = text,
                    validator: (value) {
                      if (store.email == '') {
                        return 'Campo obrigatório';
                      }

                      bool emailValid = RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(value!);

                      if (!emailValid) {
                        return 'Digite um e-mail válido';
                      }

                      return null;
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(FocusNode());

                      if (_formKey.currentState!.validate()) {
                        store.updateUserEmail(context);
                      }
                    },
                  ),
                ),
              )
            ],
          ),
          const Spacer(flex: 2),
          InkWell(
            onTap: () {},
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
                'Entrar',
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
    );
  }
}
