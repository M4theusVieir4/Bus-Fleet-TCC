import 'package:busbr/infra/base/cubits/core/core_module.dart';
import 'package:busbr/infra/core/routes/bus_br_routes.dart';
import 'package:busbr/modules/auth/login/login_module.dart';
import 'package:busbr/modules/auth/register/register_module.dart';
import 'package:busbr/modules/bus_tracker/select_bus_module.dart';
import 'package:busbr/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.module(Modular.initialRoute, module: LoginModule());
    r.module(BusBrRoutes.REGISTER, module: RegisterModule());

    r.module(BusBrRoutes.HOME, module: HomeModule());
    r.module(BusBrRoutes.SELECT_BUS, module: SelectBusModule());
  }
}
