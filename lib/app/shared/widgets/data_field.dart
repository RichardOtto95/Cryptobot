import 'package:cryptobot/app/constants/colors.dart';
import 'package:cryptobot/app/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DataField extends StatelessWidget {
  final String title;
  final double? width;
  final double? right;
  final String hint;
  final FocusNode? focusNode;
  final String? initialValue;
  final String Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onEditionComplete;
  final void Function()? onTap;
  final TextInputFormatter? mask;

  const DataField(
    this.title, {
    Key? key,
    this.width,
    this.right,
    this.hint = "",
    this.focusNode,
    this.initialValue = "",
    this.validator,
    this.onChanged,
    this.onEditionComplete,
    this.onTap,
    this.mask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textFamily(fontSize: 20),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            width: width ?? wXD(300, context, webSize: 800),
            height: wXD(50, context, webSize: 50),
            margin: EdgeInsets.only(
              bottom: wXD(10, context, webHeight: 30),
              top: wXD(5, context, webHeight: 5),
              right: right ?? wXD(0, context, webSize: 80),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: wXD(10, context, webSize: 10)),
            child: onTap != null
                ? SelectableText(
                    initialValue ?? hint,
                    style: textFamily(
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                    ),
                  )
                : TextFormField(
                    initialValue: initialValue,
                    decoration: InputDecoration.collapsed(hintText: hint),
                    cursorColor: primaryColor,
                    focusNode: focusNode,
                    validator: (val) {
                      if (val == null || val == "") {
                        return "Preenchar o campo corretamente";
                      }
                      if (validator != null) validator!;
                      return "";
                    },
                    onChanged: onChanged,
                    onEditingComplete: onEditionComplete,
                    inputFormatters: mask != null ? [mask!] : [],
                    style: textFamily(
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
