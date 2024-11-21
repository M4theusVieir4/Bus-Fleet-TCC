import 'dart:async';

import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:busbr/infra/base/cubits/core/core_module.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});
  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  Completer<AndroidMapRenderer?>? _initializedRendererCompleter;

  @override
  void initState() {
    super.initState();
  }

  Future<AndroidMapRenderer?> initializeMapRenderer() async {
    if (_initializedRendererCompleter != null) {
      return _initializedRendererCompleter!.future;
    }

    final Completer<AndroidMapRenderer?> completer =
        Completer<AndroidMapRenderer?>();
    _initializedRendererCompleter = completer;

    final GoogleMapsFlutterPlatform mapsImplementation =
        GoogleMapsFlutterPlatform.instance;
    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      unawaited(mapsImplementation
          .initializeWithRenderer(AndroidMapRenderer.latest)
          .then((AndroidMapRenderer initializedRenderer) =>
              completer.complete(initializedRenderer)));
    } else {
      completer.complete(null);
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    final AppDesign appDesign = AppDesign();
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    final GoogleMapsFlutterPlatform mapsImplementation =
        GoogleMapsFlutterPlatform.instance;

    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      mapsImplementation.useAndroidViewSurface = true;
      initializeMapRenderer();
    }

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
