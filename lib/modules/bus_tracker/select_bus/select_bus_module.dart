import 'package:busbr/infra/base/cubits/core/core_module.dart';
import 'package:busbr/modules/bus_tracker/select_bus/cubit/select_bus_controller.dart';
import 'package:busbr/modules/bus_tracker/select_bus/select_bus_page.dart';
import 'package:busbr/modules/home/cubit/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SelectBusModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(SelectBusController.new);
  }

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => SelectBusPage());
  }
}
