import 'package:cryptobot/app/modules/settings/settings_Page.dart';
import 'package:cryptobot/app/modules/settings/settings_store.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SettingsModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SettingsStore()),
  ];

  @override
  Widget get view => const SettingsPage();
}
