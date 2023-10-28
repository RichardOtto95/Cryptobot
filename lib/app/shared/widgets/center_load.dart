import 'package:cryptobot/app/constants/colors.dart';
import 'package:cryptobot/app/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CenterLoad extends StatelessWidget {
  const CenterLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth(context),
      height: maxHeight(context),
      alignment: Alignment.center,
      child: const SpinKitSpinningLines(color: primaryColor),
    );
  }
}
