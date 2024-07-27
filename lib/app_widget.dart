import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppDesign appDesign = AppDesign();
    return DesignSystem(
        appDesign: appDesign,
        child: LayoutBuilder(builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig(
                designScreenWidth: 390,
                designScreenHeight: 844,
              ).init(constraints, orientation);
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Slidy',
                theme: ThemeData(primarySwatch: Colors.blue),
                routerDelegate: Modular.routerDelegate,
                routeInformationParser: Modular.routeInformationParser,
              );
            },
          );
        }));
  }
}
