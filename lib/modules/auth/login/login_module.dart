import 'package:busbr/modules/auth/login/cubit/login_cubit.dart';
import 'package:busbr/modules/auth/login/login_page.dart';
import 'package:busbr/modules/auth/login/login_page2.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(LoginCubit.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const LoginPage());
  }
}
