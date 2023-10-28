import 'package:cryptobot/app/core/models/time_model.dart';
import 'package:cryptobot/app/shared/utilities.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class OperationWidget extends StatelessWidget {
  final Map<String, dynamic> operationData;
  final bool lastItem;
  const OperationWidget({
    Key? key,
    required this.operationData,
    required this.lastItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime _date = operationData["created_at"] == null
        ? DateTime.now()
        : operationData["created_at"].toDate();
    Responsible responsible = Responsible(context);
    return SizedBox(
      width: maxWidth(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: wXD(16, context, webSize: 70)),
          Column(
            children: [
              // Container(
              //   height: wXD(10, context),
              //   width: 1,
              //   color: gray,
              // ),
              Container(
                height: wXD(14, context, webSize: 15),
                width: wXD(14, context, webSize: 15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: white,
                  border: Border.all(color: gray),
                ),
              ),
              Container(
                height: wXD(60, context, webHeight: 70),
                width: 1,
                color: lastItem ? transparent : gray,
              )
            ],
          ),
          SizedBox(width: wXD(12, context, webSize: 30)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: wXD(3, context, webHeight: 3)),
              Text(
                Time(_date).completeDate(upperCase: true, dotted: true),
                style: textFamily(color: Color(0x50000000), fontSize: 10),
              ),
              SizedBox(height: wXD(2, context, webHeight: 3.5)),
              operationData["description"] != null
                  ? RichText(
                      text: TextSpan(
                        style: textFamily(color: black, fontSize: 16),
                        children: [
                          TextSpan(
                            text:
                                "${formatCurrency(operationData['value'])} R\$ ",
                            style: textFamily(color: red),
                          ),
                          TextSpan(text: operationData["description"]),
                        ],
                      ),
                    )
                  : RichText(
                      text: TextSpan(
                        style: textFamily(color: black, fontSize: 16),
                        children: [
                          TextSpan(
                            text: "${operationData['value']} R\$ ",
                            style: textFamily(color: red),
                          ),
                          TextSpan(
                              text:
                                  "by ${operationData["card_type"]} (*${operationData["last_card_numbers"]})"),
                          if (responsible.isWeb())
                            TextSpan(
                                text:
                                    " by ${operationData["card_type"]} (*$operationData['last_card_numbers'])")
                        ],
                      ),
                    ),
              if (responsible.isMobile())
                Text(
                  "at $operationData['created_at']",
                  style: textFamily(color: black, fontSize: 16),
                )
            ],
          )
        ],
      ),
    );
  }
}
