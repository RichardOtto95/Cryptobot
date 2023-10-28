import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptobot/app/modules/main/main_store.dart';
import 'package:cryptobot/app/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../constants/colors.dart';
import '../home_store.dart';
import 'operation_widget.dart';

class Historic extends StatefulWidget {
  const Historic({Key? key}) : super(key: key);

  @override
  _HistoricState createState() => _HistoricState();
}

class _HistoricState extends State<Historic> {
  final HomeStore homeStore = Modular.get();
  final MainStore mainStore = Modular.get();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      padding: EdgeInsets.only(
        top: wXD(15, context, webHeight: 120),
        left: wXD(10, context, webSize: 400),
      ),
      reverse: true,
      child: Container(
        alignment: Alignment.center,
        width: maxWidth(context),
        child: Observer(builder: (context) {
          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(mainStore.authStore.user!.uid)
                .collection("historic")
                .orderBy("created_at")
                .snapshots(),
            builder: (context, historicSnap) {
              if (!historicSnap.hasData) {
                return const SpinKitSpinningLines(color: primaryColor);
              }
              List<DocumentSnapshot<Map<String, dynamic>>> historicList =
                  historicSnap.data!.docs;
              if (historicList.isEmpty) {
                return const Text("Sem histórico ainda");
              }
              return Column(
                children: List.generate(
                  historicList.length,
                  (index) => OperationWidget(
                    lastItem: index == historicList.length - 1,
                    operationData: historicList[index].data()!,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
