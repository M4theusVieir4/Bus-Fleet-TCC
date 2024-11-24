import 'package:busbr/infra/base/cubits/core/core_module.dart';
import 'package:busbr/modules/home/cubit/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(HomeController.new);
  }

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute,
        child: (_) => HomePage(
              navigateToNotification: r.args.data[0],
              navigateToConfiguration: r.args.data[1],
            ));
  }
}
