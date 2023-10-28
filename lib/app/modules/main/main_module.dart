import 'package:cryptobot/app/modules/main/main_Page.dart';
import 'package:cryptobot/app/modules/main/main_store.dart';
// ignore: implementation_imports, unused_import
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/services/auth/auth_service.dart';
import '../../core/services/auth/auth_store.dart';

class MainModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton((i) => AuthStore()),
        Bind.lazySingleton((i) => AuthService()),
        Bind.lazySingleton((i) => MainStore()),
      ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (_, args) => const MainPage()),
  ];
}
