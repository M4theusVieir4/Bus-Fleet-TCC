import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ADPFlavorBanner extends StatefulWidget {
  const ADPFlavorBanner({
    super.key,
    required this.flavorName,
    required this.child,
  });

  final String flavorName;
  final Widget child;

  @override
  State<ADPFlavorBanner> createState() => _ADPFlavorBannerState();
}

class _ADPFlavorBannerState extends State<ADPFlavorBanner> {
  late _BannerConfig bannerConfig;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      bannerConfig = _getDefaultBanner();
      return Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          widget.child,
          _buildBanner(context),
        ],
      );
    }
    return widget.child;
  }

  _BannerConfig _getDefaultBanner() {
    var name = '';
    var color = Colors.green;

    switch (widget.flavorName) {
      case 'dev':
        name = 'DEV';
        color = Colors.green;
        break;
      case 'prod':
        name = 'PROD';
        color = Colors.red;
        break;
      case 'qa':
        name = 'QA';
        color = Colors.orange;
        break;
    }
    return _BannerConfig(bannerName: name, bannerColor: color);
  }

  SizedBox _buildBanner(BuildContext context) {
    return SizedBox(
      child: CustomPaint(
        painter: BannerPainter(
          message: bannerConfig.bannerName,
          textDirection: Directionality.of(context),
          layoutDirection: Directionality.of(context),
          location: BannerLocation.topEnd,
          color: bannerConfig.bannerColor,
        ),
      ),
    );
  }
}

class _BannerConfig {
  final String bannerName;
  final Color bannerColor;
  _BannerConfig({
    required this.bannerName,
    required this.bannerColor,
  });
}
