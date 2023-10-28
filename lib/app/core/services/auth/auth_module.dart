// import 'package:delivery_customer/app/core/services/auth/auth_Page.dart';

import 'package:flutter_modular/flutter_modular.dart';

import '../../../modules/sign/sign_store.dart';
import 'auth_service.dart';
import 'auth_store.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SignStore()),
    Bind.lazySingleton((i) => AuthStore()),
    Bind.lazySingleton((i) => AuthService()),
  ];

  @override
  final List<ModularRoute> routes = [
    // ChildRoute(Modular.initialRoute, child: (_, args) => AuthPage()),
  ];
}
