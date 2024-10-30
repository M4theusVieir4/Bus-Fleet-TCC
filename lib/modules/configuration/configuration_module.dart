import 'package:busbr/infra/base/cubits/core/core_module.dart';
import 'package:busbr/modules/auth/login/cubit/login_controller.dart';
import 'package:busbr/modules/auth/login/login_page.dart';
import 'package:busbr/modules/configuration/configuration_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConfigurationModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const ConfigurationPage());
  }
}
