import 'package:cryptobot/app/core/modules/root/root_page.dart';
import 'package:cryptobot/app/core/modules/root/root_store.dart';
import 'package:cryptobot/app/modules/main/main_module.dart';
import 'package:cryptobot/app/modules/sign/sign_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RootModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => RootStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (context, args) => const RootPage()),
    ModuleRoute("/sign", module: SignModule()),
    ModuleRoute("/main", module: MainModule()),
  ];
}
