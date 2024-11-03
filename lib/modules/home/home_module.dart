import 'package:busbr/modules/home/cubit/home_cubit.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(HomeCubit.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute,
        child: (_) => HomePage(
              navigateToNotification: r.args.data[0],
              navigateToConfiguration: r.args.data[1],
            ));
  }
}
