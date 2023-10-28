import 'package:cryptobot/app/core/models/time_model.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../constants/colors.dart';
import '../../../shared/utilities.dart';
import '../home_store.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final HomeStore homeStore = Modular.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeStore.messages.clear();
    Future.delayed(const Duration(milliseconds: 500), () {
      homeStore.messages.insert(
        0,
        {
          "date": DateTime.now(),
          "text":
              "Olá ${homeStore.mainStore.titled!.username}, eu não te vejo já tem um tempo\nComo eu posso ajudar?",
          "avatar": null,
          "author": "bot",
          "type": "BOT_MESSAGE",
          "status": "ACTIVE",
        },
      );
      homeStore.messagesKey.currentState!
          .insertItem(0, duration: const Duration(milliseconds: 300));
    });
    return Material(
      color: white,
      elevation: 1,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: wXD(20, context, webSize: 435),
          vertical: hXD(20, context, webSize: 50),
        ),
        alignment: Alignment.centerLeft,

        // height: wXD(300, context),
        width: maxWidth(context),
        decoration: const BoxDecoration(
          color: white,
        ),
        child: Observer(
          builder: (context) {
            return AnimatedList(
              key: homeStore.messagesKey,
              shrinkWrap: true,
              initialItemCount: homeStore.messages.length,
              itemBuilder: (context, index, animation) {
                final message = homeStore.messages[index];
                if (homeStore.messages[index]["status"] == "BOT_WRITING") {
                  return BotWritingIndication(animation: animation);
                }
                if (homeStore.messages[index]["type"] == "BOT_MESSAGE" ||
                    homeStore.messages[index]["type"] == "USER_MESSAGE") {
                  return ChatMessage(
                    date: message["date"],
                    text: message["text"],
                    animation: animation,
                  );
                }
                if (homeStore.messages[index]["type"] ==
                    "CONFIRM_BANK_TRANSFER") {
                  return ConfirmTransferMessage(
                    amount: message["amount"],
                    animation: animation,
                    date: message["date"],
                    procedureDate: message["procedure_date"]
                        .toString()
                        .substring(0, 10)
                        .replaceAll("-", ""),
                    description: message["description"],
                    from: message["from"],
                    text: message["text"],
                    to: message["to"],
                  );
                }
                return Container();
              },
            );
          },
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final DateTime date;
  final String text;
  final String? avatar;
  final Animation<double> animation;

  const ChatMessage({
    Key? key,
    required this.date,
    required this.text,
    this.avatar,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("animation: ${animation.value}");
    return Padding(
      padding: EdgeInsets.symmetric(vertical: wXD(10, context, webHeight: 10)),
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          // print("animatino: ${animation.value}");
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.centerLeft,
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1200),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: wXD(10, context, webSize: 15)),
                        width: wXD(50, context, webSize: 75),
                        height: wXD(50, context, webSize: 75),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: gray,
                        ),
                      ),
                      SizedBox(
                        width: wXD(180, context, webSize: 800),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SelectableText(Time(date).dayHour(upperCase: true),
                                style: textFamily(
                                    color: Color(0x50000000), fontSize: 10)),
                            SizedBox(height: wXD(2, context)),
                            SelectableText(
                              text,
                              style: textFamily(color: black, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class BotWritingIndication extends StatefulWidget {
  final Animation<double> animation;
  const BotWritingIndication({Key? key, required this.animation})
      : super(key: key);

  @override
  State<BotWritingIndication> createState() => _BotWritingIndicationState();
}

class _BotWritingIndicationState extends State<BotWritingIndication>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, _) {
        // print("animatino: ${widget.animation.value}");
        return ScaleTransition(
          scale: widget.animation,
          alignment: Alignment.centerLeft,
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 1200),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        right: wXD(10, context, webSize: 7),
                        top: wXD(10, context, webHeight: 10),
                        bottom: wXD(10, context, webHeight: 10),
                      ),
                      width: wXD(50, context, webSize: 13),
                      height: wXD(50, context, webSize: 13),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: gray,
                      ),
                    ),
                    SpinKitThreeBounce(
                      duration: const Duration(seconds: 2),
                      itemBuilder: (context, index) {
                        return Container(
                          height: wXD(10, context, webHeight: 10),
                          width: wXD(10, context, webHeight: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: gray),
                            shape: BoxShape.circle,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ConfirmTransferMessage extends StatelessWidget {
  final DateTime date;
  final String procedureDate;
  final String text;
  final String from;
  final String to;
  final double amount;
  final String description;
  final String? avatar;
  final Animation<double> animation;

  ConfirmTransferMessage({
    Key? key,
    required this.date,
    required this.procedureDate,
    required this.text,
    this.avatar,
    required this.animation,
    required this.from,
    required this.to,
    required this.amount,
    required this.description,
  }) : super(key: key);

  final HomeStore homeStore = Modular.get();

  final CurrencyTextInputFormatter _formatter =
      CurrencyTextInputFormatter(symbol: 'R\$');

  @override
  Widget build(BuildContext context) {
    // print("animation: ${animation.value}");
    return Padding(
      padding: EdgeInsets.symmetric(vertical: wXD(10, context, webHeight: 10)),
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          // print("animatino: ${animation.value}");
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.centerLeft,
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1200),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: wXD(10, context, webSize: 7)),
                        width: wXD(50, context, webSize: 13),
                        height: wXD(50, context, webSize: 13),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: gray,
                        ),
                      ),
                      SizedBox(
                        width: wXD(180, context, webSize: 150),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SelectableText(Time(date).dayHour(upperCase: true),
                                style: textFamily(
                                    color: Color(0x50000000), fontSize: 10)),
                            SizedBox(height: wXD(2, context)),
                            SelectableText(
                              text,
                              style: textFamily(color: black, fontSize: 20),
                            ),
                            SizedBox(height: wXD(2, context)),
                            transferMessageLine(
                                context: context,
                                title: "De:",
                                initialValue: from,
                                fromAmount: "6 705,07",
                                onChanged: (val) {}),
                            transferMessageLine(
                              context: context,
                              title: "Para:",
                              initialValue: to,
                              onChanged: (val) {
                                homeStore.receiverText = val;
                                if (homeStore.receiverSelected ==
                                    homeStore.receiverText) {
                                  homeStore.receiverText = "";
                                }
                              },
                            ),
                            transferMessageLine(
                              context: context,
                              title: "Montante:",
                              initialValue:
                                  "R\$ ${_formatter.format((amount * 100).toString())}",
                              mask: _formatter,
                              onChanged: (val) => homeStore.procedureValue =
                                  _formatter.getUnformattedValue().toDouble() /
                                      100,
                            ),
                            transferMessageLine(
                              title: "Data:",
                              context: context,
                              initialValue: dateDottedMask.maskText(
                                procedureDate.substring(6, 8) +
                                    procedureDate.substring(4, 6) +
                                    procedureDate.substring(0, 4),
                              ),
                              mask: dateDottedMask,
                              onChanged: (val) {
                                String dateString =
                                    dateDottedMask.unmaskText(val);
                                if (dateString.length == 8) {
                                  homeStore.procedureDate = DateTime(
                                    int.parse(dateString.substring(6, 8)),
                                    int.parse(dateString.substring(4, 6)),
                                    int.parse(dateString.substring(0, 4)),
                                  );
                                  // print(
                                  // "procedureDate: ${homeStore.procedureDate}");
                                }
                              },
                            ),
                            transferMessageLine(
                              context: context,
                              title: "Descrição:",
                              initialValue: description,
                              onChanged: (val) =>
                                  homeStore.procedureDescription = val,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget transferMessageLine({
    required String title,
    required String initialValue,
    required void Function(String) onChanged,
    String? fromAmount,
    TextInputFormatter? mask,
    required BuildContext context,
  }) {
    return SizedBox(
      width: wXD(200, context, webSize: 200),
      child: Row(
        children: [
          SelectableText(
            title,
            style: textFamily(color: gray, fontSize: 24),
          ),
          fromAmount != null
              ? Text(
                  initialValue,
                  style: textFamily(color: blue, fontSize: 24),
                )
              : Flexible(
                  child: TextFormField(
                    initialValue: initialValue,
                    inputFormatters: mask != null ? [mask] : null,
                    style: textFamily(color: blue, fontSize: 24),
                    decoration: const InputDecoration.collapsed(hintText: ""),
                    onChanged: onChanged,
                  ),
                ),
          if (fromAmount != null)
            SelectableText(
              "(R\$ $fromAmount)",
              style: textFamily(color: gray, fontSize: 24),
            ),
          if (fromAmount != null) SizedBox(width: wXD(10, context, webSize: 5)),
          // if (fromAmount != null) const Spacer(),
        ],
      ),
    );
  }
}
