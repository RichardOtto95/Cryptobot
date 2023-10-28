// ignore_for_file: file_names

import 'package:cryptobot/app/modules/home/home_module.dart';
import 'package:cryptobot/app/modules/main/main_store.dart';
import 'package:cryptobot/app/modules/settings/settings_module.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../constants/colors.dart';
import '../../shared/cryptobot_scroll_behavior.dart';
import '../../shared/utilities.dart';
import '../../shared/widgets/center_load.dart';
import '../../shared/widgets/crypto_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ModularState<MainPage, MainStore> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<WidgetModule> modules = [
    HomeModule(),
    SettingsModule(),
  ];

  @override
  Widget build(BuildContext context) {
    Responsible responsible = Responsible(context);

    return WillPopScope(
      onWillPop: () async {
        print("WillPopScope");
        return false;
      },
      child: Observer(builder: (context) {
        if (store.titled == null) {
          return const CenterLoad();
        }
        return Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
            backgroundColor: white,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(wXD(8, context, webSize: 2)),
                  width: double.infinity,
                  height: wXD(30, context, webHeight: 60),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                    color: red,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "CryptoBot Menu",
                    style: textFamily(color: white, fontSize: 19),
                  ),
                ),
                DrawerTile(
                    title: "CryptoBot",
                    onTap: () {
                      store.page = 0;
                      Modular.to.pop();
                    },
                    icon: Icons.android),
                DrawerTile(
                    title: "Automações",
                    onTap: () {
                      Modular.to.pop();
                    }),
                DrawerTile(
                    title: "Configurações",
                    onTap: () {
                      store.page = 1;
                      Modular.to.pop();
                    }),
                DrawerTile(
                  title: "Logout",
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Modular.to.pushNamed("/sign");
                  },
                  icon: Icons.logout,
                ),

                // Ink(
                // decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(17))),
                // child:

                // )
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(top: wXD(10, context, webHeight: 25)),
            child: FloatingActionButton(
              backgroundColor: white,
              onPressed: () => scaffoldKey.currentState!.openDrawer(),
              child: const Icon(
                Icons.menu,
                color: red,
                size: 30,
              ),
            ),
          ),
          appBar: responsible.isMobile()
              ? const CryptobotBar(
                  backgroundColor: white,
                )
              : null,
          body: ScrollConfiguration(
            behavior: CryptobotScrollBehavior(),
            child: Observer(
              builder: (context) => modules[store.page],
            ),
          ),
        );
      }),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final IconData icon;

  const DrawerTile({
    Key? key,
    this.icon = Icons.settings,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(wXD(8, context, webSize: 10)),
      width: double.infinity,
      height: wXD(30, context, webHeight: 60),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(17)),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(left: wXD(15, context, webSize: 15)),
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(
                icon,
                size: wXD(15, context, webSize: 30),
                color: red,
              ),
              SizedBox(width: wXD(5, context, webSize: 7)),
              Text(title,
                  style: textFamily(
                    color: red,
                    fontSize: 17,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
