import 'package:cryptobot/app/constants/colors.dart';
import 'package:cryptobot/app/shared/utilities.dart';
import 'package:flutter/material.dart';

class CryptoTitle extends StatelessWidget {
  final String title;
  final double size;
  final Color color;
  final double left;
  final double top;
  final double right;
  final double bottom;
  final double webLeft;
  final double webTop;
  final double webRight;
  final double webBottom;
  const CryptoTitle(
    this.title, {
    Key? key,
    this.size = 27,
    this.color = titleColor,
    this.left = 10,
    this.top = 10,
    this.right = 10,
    this.bottom = 10,
    this.webLeft = 100,
    this.webTop = 60,
    this.webRight = 10,
    this.webBottom = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        wXD(left, context, webSize: webLeft),
        wXD(top, context, webHeight: webTop),
        wXD(right, context, webSize: webRight),
        wXD(bottom, context, webHeight: webBottom),
      ),
      child: Text(
        title,
        style: textFamily(
          fontSize: size,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
