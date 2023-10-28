import 'package:cryptobot/app/core/modules/splash/splash_page.dart';
import 'package:cryptobot/app/core/modules/splash/splash_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SplashStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    // ignore: prefer_const_constructors
    ChildRoute('/', child: (_, args) => SplashPage()),
  ];
}
