import 'dart:ui';

import 'package:cryptobot/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utilities.dart';

class LoadCircularOverlay extends StatelessWidget {
  const LoadCircularOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: maxHeight(context),
      width: maxWidth(context),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          color: black.withOpacity(.4),
          alignment: Alignment.center,
          child: const SpinKitSpinningLines(color: primaryColor),
        ),
      ),
    );
  }
}
