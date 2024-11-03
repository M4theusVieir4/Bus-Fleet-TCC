import 'package:busbr/modules/configuration/configuration_module.dart';
import 'package:busbr/modules/home/home_module.dart';
import 'package:busbr/modules/navigation/navigation_nested_page.dart';
import 'package:busbr/modules/notification/notification_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NavigationNestedModule extends Module {
  @override
  List<Module> get imports => [
        HomeModule(),
        ConfigurationModule(),
        NotificationModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => NavigationNestedPage(route: r.args.data),
      children: [
        ParallelRoute.module(
          '/home',
          module: HomeModule(),
        ),
        ParallelRoute.module(
          '/configuration',
          module: ConfigurationModule(),
        ),
        ParallelRoute.module(
          '/notification',
          module: NotificationModule(),
        ),
      ],
    );
  }
}
