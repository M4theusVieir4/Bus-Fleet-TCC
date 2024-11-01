import 'package:busbr/modules/home/cubit/home_cubit.dart';
import 'package:busbr/modules/notification/notification_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NotificationModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(HomeCubit.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => NotificationPage());
  }
}
