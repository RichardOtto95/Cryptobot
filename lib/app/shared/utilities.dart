import 'package:cryptobot/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'widgets/score_date_picker.dart';

/// Valor da largura total: 375
double wXD(double size, BuildContext context,
    {double? webSize, double? webHeight}) {
  Responsible responsible = Responsible(context);
  if (responsible.isWeb() && webHeight != null) {
    return MediaQuery.of(context).size.height / 1080 * webHeight;
  }
  if (responsible.isWeb() && webSize != null) {
    return MediaQuery.of(context).size.width / 1920 * webSize;
  }
  return MediaQuery.of(context).size.width / 375 * size;
}

/// Valor da largura total: 703
double hXD(double size, BuildContext context, {double? webSize}) {
  Responsible responsible = Responsible(context);
  if (responsible.isWeb() && webSize != null) {
    return MediaQuery.of(context).size.height / 1080 * webSize;
  }
  return MediaQuery.of(context).size.height / 703 * size;
}

double maxHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double maxWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

showToast(String msg) {
  Fluttertoast.showToast(msg: msg);
}

String formatCurrency(var value) {
  var newValue = NumberFormat("#,##0.00", "pt_BR");
  return newValue.format(value);
}

TextStyle textFamily({
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? height,
  Color? color,
}) {
  return GoogleFonts.montserrat(
    fontSize: fontSize ?? 13,
    color: color ?? textColor,
    fontWeight: fontWeight ?? FontWeight.w500,
    fontStyle: fontStyle,
    height: height,
  );
}

void pickDate(context, {required void Function(DateTime?) onConfirm}) async {
  OverlayEntry? dateOverlay;
  dateOverlay = OverlayEntry(
    maintainState: true,
    builder: (context) => ScoreDatePicker(
      onConfirm: (date) {
        onConfirm(date);
        dateOverlay!.remove();
        dateOverlay = null;
      },
      onCancel: () {
        dateOverlay!.remove();
        dateOverlay = null;
      },
    ),
  );
  Overlay.of(context)!.insert(dateOverlay!);
}

final dateDottedMask =
    MaskTextInputFormatter(mask: '##.##.####', filter: {"#": RegExp(r'[0-9]')});

final phoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

final cpfMask = MaskTextInputFormatter(
    mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

class Responsible {
  final BuildContext context;

  Responsible(this.context);

  double screenHeight() => MediaQuery.of(context).size.height;

  double screenWidth() => MediaQuery.of(context).size.width;

  bool isMobile() {
    // print("screenHeight: ${screenHeight()}");
    // print("screenWidth: ${screenWidth()}");
    if (screenHeight() < 950 && screenWidth() < 450) {
      // print("isMobile: true");
      return true;
    }
    // print("isMobile: false");
    return false;
  }

  bool isWeb() {
    // print("screenHeight: ${screenHeight()}");
    // print("screenWidth: ${screenWidth()}");
    if (screenHeight() > 950 || screenWidth() > 450) {
      // print("isWeb: true");
      return true;
    }
    // print("isWeb: false");
    return false;
  }
}
