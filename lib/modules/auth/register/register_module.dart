import 'package:busbr/infra/base/cubits/core/core_module.dart';
import 'package:busbr/modules/auth/register/cubit/register_controller.dart';
import 'package:busbr/modules/auth/register/register_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(RegisterController.new);
  }

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const RegisterPage());
  }
}
