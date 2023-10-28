import 'package:cryptobot/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../shared/utilities.dart';
import '../sign_store.dart';

class SignVerifyPhone extends StatelessWidget {
  const SignVerifyPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignStore store = Modular.get();
    return Scaffold(
      backgroundColor: const Color(0xffeaeaea),
      body: Column(
        children: [
          const Spacer(),
          Container(
            width: wXD(1170, context),
            height: hXD(672, context),
            decoration: const BoxDecoration(
                color: Color(0xfffafafa),
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            alignment: Alignment.topCenter,
            child: Column(
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
                    'Código de verificação',
                    style: textFamily(
                      color: red,
                      fontSize: hXD(28, context),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(flex: 3),
                SelectableText(
                  'Digite o código de verificação enviado por SMS',
                  style: textFamily(
                    color: const Color(0xff212122),
                    fontSize: hXD(23, context),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(flex: 3),
                Container(
                  color: const Color(0xfffafafa),
                  width: 301,
                  child: PinCodeTextField(
                    cursorColor: red,
                    autoFocus: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    autoDismissKeyboard: false,
                    onSubmitted: (e) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      store.verifyCode(context);
                    },
                    keyboardType: TextInputType.number,
                    length: 6,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      fieldHeight: 50,
                      fieldWidth: 40,
                      inactiveColor: const Color(0x30707070), //
                      selectedColor: primaryColor,
                      activeColor: primaryColor,
                    ),
                    backgroundColor: const Color(0xfffafafa),
                    animationDuration: const Duration(milliseconds: 300),
                    onChanged: (value) => store.verificationCode = value,
                    beforeTextPaste: (text) {
                      return true;
                    },
                    appContext: context,
                    onCompleted: (value) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      store.verifyCode(context);
                    },
                  ),
                ),
                const Spacer(flex: 2),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    store.verifyCode(context);
                  },
                  child: Container(
                    width: wXD(238, context),
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: wXD(50, context),
                      ),
                      child: Text(
                        'Verificar',
                        style: textFamily(
                          color: const Color(0xfffafafa),
                          fontSize: hXD(28, context),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 6),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(
          left: wXD(5, context),
          bottom: hXD(35, context),
        ),
        child: InkWell(
          onTap: () {
            Modular.to.pop();
          },
          child: Text(
            '< Voltar',
            style: textFamily(
              color: red,
              fontSize: hXD(20, context),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
