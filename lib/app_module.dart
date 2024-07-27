import 'package:busbr/modules/auth/login/login_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.module(Modular.initialRoute, module: LoginModule());
  }
}
