import 'package:cryptobot/app/core/services/auth/auth_service.dart';
import 'package:cryptobot/app/modules/sign/sign_Page.dart';
import 'package:cryptobot/app/modules/sign/sign_store.dart';
import 'package:cryptobot/app/modules/sign/widgets/sign_verify_phone.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/services/auth/auth_store.dart';
import 'widgets/sign_email_page.dart';

class SignModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SignStore()),
    Bind.lazySingleton((i) => AuthService()),
    Bind.lazySingleton((i) => AuthStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const SignPage()),
    ChildRoute('/verify', child: (_, args) => const SignVerifyPhone()),
    ChildRoute('/email', child: (_, args) => const SignEmailPage()),
  ];
}
