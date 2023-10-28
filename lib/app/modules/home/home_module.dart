import 'package:cryptobot/app/modules/home/home_Page.dart';
import 'package:cryptobot/app/modules/home/home_store.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends WidgetModule {
  HomeModule({Key? key}) : super(key: key);

  @override
  List<Bind<Object>> get binds => [Bind.lazySingleton((i) => HomeStore())];

  @override
  Widget get view => const HomePage();
}
