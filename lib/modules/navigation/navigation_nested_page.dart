import 'package:busbr/infra/config/navigation_manager/navigate.dart';
import 'package:busbr/infra/core/routes/bus_br_routes.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

enum LandingRoutes {
  data(0),
  vehicleTracker(1),
  userArea(2);

  final int currentIndex;

  const LandingRoutes(this.currentIndex);
}

class NavigationNestedPage extends StatefulWidget {
  final LandingRoutes? route;

  const NavigationNestedPage({
    super.key,
    this.route,
  });

  @override
  State<NavigationNestedPage> createState() => _NavigationNestedPageState();
}

class _NavigationNestedPageState extends State<NavigationNestedPage> {
  int _indexSelected = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() => _indexSelected = 0);
        Navigate.pushNamed(BusBrRoutes.HOME, arguments: <void Function()>[
          _navigateToNotification,
          _navigateToConfiguration
        ]);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Scaffold(
      backgroundColor: design.neutral700,
      extendBody: true,
      body: const SafeArea(
        bottom: true,
        top: false,
        child: RouterOutlet(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: design.neutral900,
        buttonBackgroundColor: design.tertiary100,
        color: design.primary,
        animationDuration: Duration(
          milliseconds: 600,
        ),
        index: _indexSelected,
        onTap: (index) {
          _indexSelected = index;
          switch (_indexSelected) {
            case 0:
              Modular.to.pushNamed(BusBrRoutes.HOME,
                  arguments: <void Function()>[
                    _navigateToNotification,
                    _navigateToConfiguration
                  ]);
              break;
            case 1:
              Modular.to.pushNamed(BusBrRoutes.NOTIFICATION);
              break;
            case 2:
              Modular.to.pushNamed(BusBrRoutes.CONFIGURATION);
              break;
          }
        },
        items: [
          Icon(
            Icons.home,
          ),
          Image.asset(
            AppIcons.bell,
            height: 22,
            width: 22,
          ),
          Image.asset(
            AppIcons.menu,
            height: 24,
            width: 24,
          ),
        ],
      ),
    );
  }

  void _onPageChange({
    required int index,
    required String route,
    List<VoidCallback>? args,
  }) {
    if (index != _indexSelected) {
      setState(
        () => _indexSelected = index,
      );
      Navigate.pushNamed(
        route,
        arguments: args,
      );
    }
  }

  void _navigateToNotification() {
    _onPageChange(
      index: 1,
      route: BusBrRoutes.NOTIFICATION,
    );
  }

  void _navigateToConfiguration() {
    _onPageChange(
      index: 2,
      route: BusBrRoutes.CONFIGURATION,
    );
  }
}
