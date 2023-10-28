import 'package:cryptobot/app/modules/home/widgets/chat_bot.dart';
import 'package:cryptobot/app/shared/cryptobot_scroll_behavior.dart';
import 'package:cryptobot/app/shared/utilities.dart';
import 'package:cryptobot/app/shared/widgets/center_load.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cryptobot/app/modules/home/home_store.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'widgets/crypto_text_input.dart';
import 'widgets/historic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    Responsible responsible = Responsible(context);
    return Observer(
      builder: (context) {
        if (store.account == null) {
          return const CenterLoad();
        }
        return Stack(
          children: [
            ScrollConfiguration(
              behavior: CryptobotScrollBehavior(),
              child: Column(
                children: const [
                  Expanded(child: Historic()),
                  ChatBot(),
                  CryptobotTextInput(),
                ],
              ),
            ),
            if (responsible.isWeb())
              Positioned(
                top: 30,
                right: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SelectableText(
                      store.account!["amount"].toString(),
                      style: textFamily(color: black, fontSize: 16),
                    ),
                    SizedBox(height: wXD(.5, context)),
                    SelectableText(
                      "Conta principal",
                      style: textFamily(
                          color: const Color(0x50000000), fontSize: 10),
                    ),
                    SizedBox(height: wXD(2, context)),
                    SelectableText(
                      store.account!["amount"].toString(),
                      style: textFamily(color: black, fontSize: 16),
                    ),
                    SizedBox(height: wXD(.5, context)),
                    SelectableText(
                      "Contas registradas",
                      style: textFamily(
                          color: const Color(0x50000000), fontSize: 10),
                    ),
                  ],
                ),
              )
          ],
        );
      },
    );
  }
}
