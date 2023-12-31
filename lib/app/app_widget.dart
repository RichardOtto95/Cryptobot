import 'package:cryptobot/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        backgroundColor: white,
      ),
      debugShowCheckedModeBanner: false,
      title: "DeliveryApp",
      initialRoute: "/",
    ).modular();
  }
}
