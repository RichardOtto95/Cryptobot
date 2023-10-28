import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../constants/colors.dart';
import '../../../shared/utilities.dart';
import '../home_store.dart';

class CryptobotTextInput extends StatefulWidget {
  const CryptobotTextInput({Key? key}) : super(key: key);

  @override
  _CryptobotTextInputState createState() => _CryptobotTextInputState();
}

class _CryptobotTextInputState extends State<CryptobotTextInput>
    with SingleTickerProviderStateMixin {
  final HomeStore homeStore = Modular.get();

  late AnimationController animationController;
  late Widget switcherChild;

  late SpeechToText _speech;
  bool _isListening = false;
  double _confidence = 1.0;

  @override
  void initState() {
    // _initSpeech();
    _speech = SpeechToText();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  // void _initSpeech() async {
  //   _speechEnabled = await _speechToText.initialize();
  //   setState(() {});
  // }

  // void _startListening() async {
  //   await _speechToText.listen(
  //     onResult: (result) {
  //       print("");
  //       print("finalResult: ${result.finalResult}");
  //       print("jsonRes: ${result.toJson()}");

  //       homeStore.textController.clear();
  //       homeStore.textController.text = result.recognizedWords;
  //       homeStore.onChanged(homeStore.textController.text);
  //       print("result: ${result.recognizedWords}");
  //     },
  //   );
  //   setState(() {});
  // }

  // void _stopListening() async {
  //   await _speechToText.stop();
  //   setState(() {});
  // }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            homeStore.textController.text = val.recognizedWords;
            homeStore.onChanged(homeStore.textController.text);
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      homeStore.textController.clear();
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsible responsible = Responsible(context);

    List<String> receivers = [
      "Miguel Almeida",
      "Michael Roberto",
      "Michele Guimarães",
      "Marcello Augusto",
      "Michon D'elvoie",
      "Rafael Bundão"
    ];

    return Material(
      elevation: 1,
      child: Container(
        // height: responsible.isMobile() ? wXD(60, context) : hXD(100, context),
        width: maxWidth(context),
        padding: EdgeInsets.only(
          left: wXD(15, context),
          right: wXD(5, context),
          top: wXD(10, context, webHeight: 22.5),
          bottom: wXD(10, context, webHeight: 22.5),
        ),
        color: red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Observer(
              builder: (context) {
                // print(
                //     "homeStore.procedureReceiver: ${homeStore.procedureReceiver}");
                List<String> suggestions = [];
                for (String receiver in receivers) {
                  // print(
                  //     "receiver.contains(homeStore.procedureReceiver): ${receiver.toLowerCase().contains(homeStore.procedureReceiver.toLowerCase())}");
                  if (receiver
                      .toLowerCase()
                      .contains(homeStore.receiverText.toLowerCase())) {
                    suggestions.add(receiver);
                  }
                }

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: homeStore.receiverText != "" &&
                          homeStore.procedure == "BANK_TRANSFER"
                      ? wXD(100, context, webHeight: 160)
                      : 0,
                  padding: EdgeInsets.only(
                    left: wXD(15, context, webSize: 70),
                  ),
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: suggestions
                          .map((receiver) => InkWell(
                                onTap: () =>
                                    homeStore.setProcedureReceiver(receiver),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: wXD(5, context, webHeight: 4)),
                                  child: Observer(builder: (context) {
                                    // print(
                                    //     "${homeStore.receiverSelected} == $receiver ${homeStore.receiverSelected == receiver}");
                                    return AnimatedDefaultTextStyle(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      style: textFamily(
                                        color: white,
                                        fontSize: homeStore.receiverSelected ==
                                                receiver
                                            ? 20
                                            : 17,
                                        fontWeight:
                                            homeStore.receiverSelected ==
                                                    receiver
                                                ? FontWeight.w800
                                                : FontWeight.w500,
                                      ),
                                      child: Text(
                                        receiver,
                                      ),
                                    );
                                  }),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                );
              },
            ),
            Observer(
              builder: (context) {
                switcherChild = Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    responsible.isMobile() ? Container() : const Spacer(),
                    Container(
                      height: wXD(40, context, webSize: 50),
                      width: wXD(308, context, webSize: 1120),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          border: Border.all(color: white)),
                      child: Row(
                        children: [
                          Container(
                            height: wXD(40, context, webSize: 50),
                            width: wXD(55, context, webSize: 85),
                            decoration: const BoxDecoration(
                                border:
                                    Border(right: BorderSide(color: white))),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.menu,
                              size: wXD(40, context, webSize: 40),
                              color: white,
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: wXD(10, context, webSize: 15),
                                vertical: wXD(7, context, webSize: 0),
                              ),
                              child: TextField(
                                controller: homeStore.textController,
                                autofocus: true,
                                onChanged: (value) =>
                                    homeStore.onChanged(value),
                                style: textFamily(
                                  color: white,
                                  fontSize: 17,
                                ),
                                decoration: InputDecoration.collapsed(
                                    hintText: 'Escreva o que você deseja',
                                    hintStyle: textFamily(
                                        fontStyle: FontStyle.italic,
                                        color: white)),
                              ),
                            ),
                          ),
                          if (responsible.isWeb())
                            InkWell(
                              onTap: () => homeStore.sendProcedure(),
                              child: Container(
                                height: hXD(50, context),
                                width: wXD(20, context),
                                decoration: const BoxDecoration(
                                    border:
                                        Border(left: BorderSide(color: white))),
                                alignment: Alignment.center,
                                child: Text(
                                  "Enviar",
                                  style: textFamily(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: white),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    AvatarGlow(
                      animate: _isListening,
                      glowColor: white,
                      endRadius: wXD(15, context, webSize: 25),
                      duration: const Duration(milliseconds: 2000),
                      repeatPauseDuration: const Duration(milliseconds: 100),
                      repeat: true,
                      child: InkWell(
                        onTap: _listen,
                        child: Icon(
                          _isListening ? Icons.mic : Icons.mic_none,
                          color: white,
                          size: wXD(30, context, webSize: 40),
                        ),
                      ),
                    ),
                    responsible.isMobile() ? Container() : const Spacer(),
                  ],
                );
                if (homeStore.procedure == "CONFIRM_BANK_TRANSFER") {
                  switcherChild = Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: wXD(15, context, webSize: 50)),
                      InkWell(
                        onTap: () => homeStore.confirmBankTransfer(),
                        child: Container(
                          height: wXD(40, context, webHeight: 45),
                          width: wXD(50, context, webSize: 30),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: white,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Enviar",
                            style: textFamily(fontSize: 17, color: black),
                          ),
                        ),
                      ),
                      Container(
                        height: wXD(40, context, webHeight: 45),
                        width: wXD(50, context, webSize: 30),
                        alignment: Alignment.center,
                        child: Text(
                          "Cancelar",
                          style: textFamily(fontSize: 17, color: white),
                        ),
                      ),
                    ],
                  );
                }
                return AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: switcherChild,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
