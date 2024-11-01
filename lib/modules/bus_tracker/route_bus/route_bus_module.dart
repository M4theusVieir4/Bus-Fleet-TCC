import 'package:busbr/modules/bus_tracker/route_bus/route_bus_page.dart';
import 'package:busbr/modules/home/cubit/home_cubit.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RouteBusModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(HomeCubit.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => RouteBusPage());
  }
}
