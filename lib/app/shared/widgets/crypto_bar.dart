import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/colors.dart';
import '../utilities.dart';

class CryptobotBar extends StatefulWidget implements PreferredSizeWidget {
  const CryptobotBar({
    Key? key,
    // this.systemOverlayStyle,
    this.height = 50,
    this.backgroundColor = const Color(0xffffffff),
  }) : super(key: key);

  final double height;

  // final SystemUiOverlayStyle? systemOverlayStyle;

  final Color backgroundColor;

  @override
  _CryptobotBarState createState() => _CryptobotBarState();

  @override
  Size get preferredSize {
    return Size.fromHeight(height);
  }
}

class _CryptobotBarState extends State<CryptobotBar> {
  SystemUiOverlayStyle _systemOverlayStyleForBrightness(Brightness brightness) {
    return brightness == Brightness.dark
        ? const SystemUiOverlayStyle(
            statusBarColor: black, statusBarIconBrightness: Brightness.light)
        : const SystemUiOverlayStyle(
            statusBarColor: white, statusBarIconBrightness: Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    final SystemUiOverlayStyle overlayStyle = _systemOverlayStyleForBrightness(
        ThemeData.estimateBrightnessForColor(widget.backgroundColor));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Material(
        elevation: 1,
        color: widget.backgroundColor,
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "6 705,07 €",
                    style: textFamily(
                      color: black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Main account",
                    style: textFamily(
                      color: black,
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
              SizedBox(width: wXD(20, context)),
            ],
          ),
        ),
      ),
    );
  }
}
