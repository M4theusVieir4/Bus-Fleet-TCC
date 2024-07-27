// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../theme/icons/app_icons.dart';
import 'configs.dart';

class DesignSystem extends InheritedWidget {
  final AppDesign appDesign;

  const DesignSystem({
    Key? key,
    required this.appDesign,
    required Widget child,
  }) : super(key: key, child: child);

  static AppDesign of(BuildContext context) {
    final layerDesign =
        context.dependOnInheritedWidgetOfExactType<DesignSystem>()?.appDesign;

    assert(layerDesign != null, 'No AppDesign found in context.');

    return layerDesign!;
  }

  static Future<void> getConfiguredDesign({
    required String theme,
  }) async {
    final config = jsonDecode(theme);

    TextStyle(
      fontSize: config['titleM']['size'],
      fontWeight:
          FontWeight.values[(config['titleM']['fontWeight'] ~/ 100) - 1],
      height: config['titleM']['height'],
      letterSpacing: config['titleM']['letterSpacing'],
    );

    TextStyle(
      fontSize: config['titleS']['size'],
      fontWeight:
          FontWeight.values[(config['titleS']['fontWeight'] ~/ 100) - 1],
      height: config['titleS']['height'],
      letterSpacing: config['titleS']['letterSpacing'],
    );
  }

  @override
  bool updateShouldNotify(DesignSystem oldWidget) {
    return appDesign != oldWidget.appDesign;
  }
}

/// Example class
class AppDesign {
  /// [Colors] - Defined on `Figma`

  /// [Primary Color]
  final Color primary;

  final Color primary100;

  final Color primary200;

  final Color primary300;

  final Color primary400;

  final Color primary500;

  final Color primary600;

  /// [Secondary Color]
  final Color secondary;

  final Color secondary100;

  final Color secondary200;

  final Color secondary300;

  final Color secondary400;

  final Color secondary500;

  final Color secondary600;

  /// [Tertiary Color]
  final Color tertiary100;

  final Color tertiary200;

  final Color tertiary300;

  final Color tertiary400;

  final Color tertiary500;

  final Color tertiary600;

  /// [Neutral Colors]
  final Color neutral;

  final Color neutral100;

  final Color neutral200;

  final Color neutral300;

  final Color neutral400;

  final Color neutral500;

  final Color neutral600;

  final Color neutral700;

  final Color neutral800;

  final Color neutral900;

  final Color error100;

  final Color info100;

  /// [Brightness]
  final String statusBarTheme;

  /// [Images]
  final Images images;

  /// [Icons]
  final CustonIcons icons;

  final ConfigIcon configIcon;

  /// [Gradient]
  final LinearGradient _gradient;

  /// [Text styles / Typography] - Defined on `Figma`
  ///
  /// Defaults to `Figtree`
  final String fontFamily;

  /// [Headings]
  final TextStyle _heading1;

  final TextStyle _heading2;

  final TextStyle _heading3;

  final TextStyle _heading4;

  final TextStyle _heading5;

  final TextStyle _heading6;

  final TextStyle _heading1SemiBold;

  final TextStyle _heading2SemiBold;

  final TextStyle _heading3SemiBold;

  final TextStyle _heading4SemiBold;

  final TextStyle _heading5SemiBold;

  final TextStyle _heading6SemiBold;

  /// [Buttons]
  final TextStyle _buttonGiant;

  final TextStyle _buttonLarge;

  final TextStyle _buttonMedium;

  final TextStyle _buttonSmall;

  final TextStyle _buttonTiny;

  /// [Subtitle, Paragraph, Caption]
  final TextStyle _subtitle;

  final TextStyle _subtitleMedium;

  final TextStyle _subtitleSemiBold;

  final TextStyle _labelLarge;

  final TextStyle _labelLargeMedium;

  final TextStyle _labelLargeSemiBold;

  final TextStyle _labelDefault;

  final TextStyle _labelDefaultMedium;

  final TextStyle _labelDefaultSemiBold;

  final TextStyle _labelMedium;

  final TextStyle _labelMediumMedium;

  final TextStyle _labelMediumSemiBold;

  final TextStyle _labelSmall;

  final TextStyle _labelSmallMedium;

  final TextStyle _labelSmallSemiBold;

  final TextStyle _labelTiny;

  final TextStyle _labelCaption;

  final TextStyle _labelCaptionMedium;

  final TextStyle _labelCaptionSemiBold;

  final TextStyle _paragraphDefault;

  final TextStyle _paragraphDefaultMedium;

  final TextStyle _paragraphDefaultSemiBold;

  final TextStyle _paragraphMedium;

  final TextStyle _paragraphSmall;

  final TextStyle _caption;

  final TextStyle _overline;

  /// [map icons]
  BitmapDescriptor mapCarOffIcon;

  BitmapDescriptor mapMotoOffIcon;

  BitmapDescriptor mapTruckOffIcon;

  BitmapDescriptor mapCarOnIcon;

  BitmapDescriptor mapMotoOnIcon;

  BitmapDescriptor mapTruckOnIcon;

  BitmapDescriptor mapRoutePoint;

  BitmapDescriptor mapFinish;

  AppDesign({
    this.fontFamily = 'IBM Plex Sans',
    this.primary = const Color(0xFF101675),
    this.primary100 = const Color(0xFF270B39),
    this.primary200 = const Color(0xFF3E1B5B),
    this.primary300 = const Color(0xFF5D3C81),
    this.primary400 = const Color(0xFF755799),
    this.primary500 = const Color(0xFFBCABD5),
    this.primary600 = const Color(0xFFEDE6FA),
    this.secondary = const Color(0xFFF2EEE6),
    this.secondary100 = const Color(0xFF815C10),
    this.secondary200 = const Color(0xFFD58A25),
    this.secondary300 = const Color(0xFFFFB264),
    this.secondary400 = const Color(0xFFFFC99A),
    this.secondary500 = const Color(0xFFFFEEE0),
    this.secondary600 = const Color(0xFFF2EEE6),
    this.tertiary100 = const Color(0xFFED5D1F),
    this.tertiary200 = const Color(0xFFED5D1F),
    this.tertiary300 = const Color(0xFFED5D1F),
    this.tertiary400 = const Color(0xFFED5D1F),
    this.tertiary500 = const Color(0xFFED5D1F),
    this.tertiary600 = const Color(0xFFED5D1F),
    this.neutral = const Color(0xFF000000),
    this.neutral100 = const Color(0xFF393E47),
    this.neutral200 = const Color(0xFF4D525C),
    this.neutral300 = const Color(0xFF707580),
    this.neutral400 = const Color(0xFF9197A3),
    this.neutral500 = const Color(0xFFC5C9D1),
    this.neutral600 = const Color(0xFFEBEBF0),
    this.neutral700 = const Color(0xFFFFFFFF),
    this.neutral800 = const Color(0xFFFFFFFF),
    this.neutral900 = const Color(0xFFFFFFFF),
    this.error100 = const Color(0xFFD9362B),
    this.info100 = const Color(0xFF2659BF),
    this.statusBarTheme = 'light',
    this.images = const Images(
      logo: AppIcons.logo,
      splashLogo: AppIcons.splashLogo,
      defaultMap: AppIcons.defaultMap,
      hybridMap: AppIcons.hybridMap,
      satelliteMap: AppIcons.satelliteMap,
    ),
    this.icons = const CustonIcons(
      refresh: AppIcons.refresh,
      calendar: AppIcons.calendar,
      car: AppIcons.car,
      filter: AppIcons.filter,
      fluentKey: AppIcons.fluentKey,
      iconParkOutlineSpeed: AppIcons.iconParkOutlineSpeed,
      routeSquare: AppIcons.routeSquare,
      unlock: AppIcons.unlock,
      lock: AppIcons.lock,
      data: AppIcons.data,
      track: AppIcons.track,
      option: AppIcons.option,
      arrowLeft: AppIcons.arrowLeft,
      openInNew: AppIcons.openInNew,
      success: AppIcons.success,
      location: AppIcons.location,
      notificationNew: AppIcons.notificationNew,
      notification: AppIcons.notification,
      user: AppIcons.user,
    ),
    this.configIcon = const ConfigIcon(
      colorOn: const Color(0xFF0C52BB),
      colorOff: const Color(0xFF4D525C),
      size: 52,
    ),
    LinearGradient gradient = const LinearGradient(
      colors: [
        const Color(0xFF461AFF),
        const Color(0xFFF4316D),
      ],
    ),
    TextStyle heading1 = const TextStyle(
      fontSize: 32,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600,
    ),
    TextStyle heading2 = const TextStyle(
      fontSize: 28,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600,
    ),
    TextStyle heading3 = const TextStyle(
      fontSize: 24,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600,
    ),
    TextStyle heading4 = const TextStyle(
      fontSize: 22,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600,
    ),
    TextStyle heading5 = const TextStyle(
      fontSize: 20,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600,
    ),
    TextStyle heading6 = const TextStyle(
      fontSize: 18,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600,
    ),
    TextStyle heading1SemiBold = const TextStyle(
      fontSize: 32,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700,
    ),
    TextStyle heading2SemiBold = const TextStyle(
      fontSize: 28,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700,
    ),
    TextStyle heading3SemiBold = const TextStyle(
      fontSize: 24,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700,
    ),
    TextStyle heading4SemiBold = const TextStyle(
      fontSize: 22,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700,
    ),
    TextStyle heading5SemiBold = const TextStyle(
      fontSize: 20,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700,
    ),
    TextStyle heading6SemiBold = const TextStyle(
      fontSize: 18,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700,
    ),
    TextStyle buttonGiant = const TextStyle(
      fontSize: 18,
      fontFamily: 'Mulish',
      fontWeight: FontWeight.w600,
    ),
    TextStyle buttonLarge = const TextStyle(
      fontSize: 16,
      fontFamily: 'Mulish',
      fontWeight: FontWeight.w500,
    ),
    TextStyle buttonMedium = const TextStyle(
      fontSize: 14,
      fontFamily: 'Mulish',
      fontWeight: FontWeight.w500,
    ),
    TextStyle buttonSmall = const TextStyle(
      fontSize: 12,
      fontFamily: 'Mulish',
      fontWeight: FontWeight.w500,
    ),
    TextStyle buttonTiny = const TextStyle(
      fontSize: 10,
      fontFamily: 'Mulish',
      fontWeight: FontWeight.w500,
    ),
    TextStyle subtitle = const TextStyle(
      fontSize: 16,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w500,
    ),
    TextStyle subtitleMedium = const TextStyle(
      fontSize: 16,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600,
    ),
    TextStyle subtitleSemiBold = const TextStyle(
      fontSize: 16,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700,
    ),
    TextStyle labelLarge = const TextStyle(
      fontSize: 15,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w500,
    ),
    TextStyle labelLargeMedium = const TextStyle(
      fontSize: 15,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600,
    ),
    TextStyle labelLargeSemiBold = const TextStyle(
      fontSize: 15,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700,
    ),
    TextStyle labelDefault = const TextStyle(
      fontSize: 14,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w500,
    ),
    TextStyle labelDefaultMedium = const TextStyle(
      fontSize: 14,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600,
    ),
    TextStyle labelDefaultSemiBold = const TextStyle(
      fontSize: 14,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700,
    ),
    TextStyle labelMedium = const TextStyle(
      fontSize: 14,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w500,
    ),
    TextStyle labelMediumMedium = const TextStyle(
      fontSize: 14,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600,
    ),
    TextStyle labelMediumSemiBold = const TextStyle(
      fontSize: 14,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700,
    ),
    TextStyle labelSmall = const TextStyle(
      fontSize: 13,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
    ),
    TextStyle labelSmallMedium = const TextStyle(
      fontSize: 13,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    ),
    TextStyle labelSmallSemiBold = const TextStyle(
      fontSize: 13,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
    ),
    TextStyle labelCaption = const TextStyle(
      fontSize: 12,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w500,
    ),
    TextStyle labelCaptionMedium = const TextStyle(
      fontSize: 12,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600,
    ),
    TextStyle labelCaptionSemiBold = const TextStyle(
      fontSize: 12,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700,
    ),
    TextStyle labelTiny = const TextStyle(
      fontSize: 12,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w500,
    ),
    TextStyle paragraphDefault = const TextStyle(
      fontSize: 14,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w500,
    ),
    TextStyle paragraphDefaultMedium = const TextStyle(
      fontSize: 14,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w600,
    ),
    TextStyle paragraphDefaultSemiBold = const TextStyle(
      fontSize: 14,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w700,
    ),
    TextStyle paragraphMedium = const TextStyle(
      fontSize: 16,
      fontFamily: 'IBM Plex Sans',
      fontWeight: FontWeight.w500,
    ),
    TextStyle paragraphSmall = const TextStyle(
      fontSize: 14,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
    ),
    TextStyle caption = const TextStyle(
      fontSize: 12,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
    ),
    TextStyle overline = const TextStyle(
      fontSize: 11,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
    ),
    this.mapCarOffIcon = BitmapDescriptor.defaultMarker,
    this.mapMotoOffIcon = BitmapDescriptor.defaultMarker,
    this.mapTruckOffIcon = BitmapDescriptor.defaultMarker,
    this.mapCarOnIcon = BitmapDescriptor.defaultMarker,
    this.mapMotoOnIcon = BitmapDescriptor.defaultMarker,
    this.mapTruckOnIcon = BitmapDescriptor.defaultMarker,
    this.mapRoutePoint = BitmapDescriptor.defaultMarker,
    this.mapFinish = BitmapDescriptor.defaultMarker,
  })  : _gradient = gradient,
        _heading1 = heading1,
        _heading2 = heading2,
        _heading3 = heading3,
        _heading4 = heading4,
        _heading5 = heading5,
        _heading6 = heading6,
        _heading1SemiBold = heading1SemiBold,
        _heading2SemiBold = heading2SemiBold,
        _heading3SemiBold = heading3SemiBold,
        _heading4SemiBold = heading4SemiBold,
        _heading5SemiBold = heading5SemiBold,
        _heading6SemiBold = heading6SemiBold,
        _buttonGiant = heading6,
        _buttonLarge = buttonLarge,
        _buttonMedium = buttonMedium,
        _buttonSmall = buttonSmall,
        _buttonTiny = buttonTiny,
        _subtitle = subtitle,
        _subtitleMedium = subtitleMedium,
        _subtitleSemiBold = subtitleSemiBold,
        _labelLarge = labelLarge,
        _labelLargeMedium = labelLargeMedium,
        _labelLargeSemiBold = labelLargeSemiBold,
        _labelDefault = labelDefault,
        _labelDefaultMedium = labelDefaultMedium,
        _labelDefaultSemiBold = labelDefaultSemiBold,
        _labelMedium = labelMedium,
        _labelMediumMedium = labelMediumMedium,
        _labelMediumSemiBold = labelMediumSemiBold,
        _labelSmall = labelSmall,
        _labelSmallMedium = labelSmallMedium,
        _labelSmallSemiBold = labelSmallSemiBold,
        _labelTiny = labelTiny,
        _labelCaption = labelCaption,
        _labelCaptionMedium = labelCaptionMedium,
        _labelCaptionSemiBold = labelCaptionSemiBold,
        _paragraphDefault = paragraphDefault,
        _paragraphDefaultMedium = paragraphDefaultMedium,
        _paragraphDefaultSemiBold = paragraphDefaultSemiBold,
        _paragraphMedium = paragraphMedium,
        _paragraphSmall = paragraphSmall,
        _caption = caption,
        _overline = overline;

  AppDesign copyWith({
    Color? primary,
    Color? primary100,
    Color? primary200,
    Color? primary300,
    Color? primary400,
    Color? primary500,
    Color? primary600,
    Color? secondary,
    Color? secondary100,
    Color? secondary200,
    Color? secondary300,
    Color? secondary400,
    Color? secondary500,
    Color? secondary600,
    Color? tertiary100,
    Color? tertiary200,
    Color? tertiary300,
    Color? tertiary400,
    Color? tertiary500,
    Color? tertiary600,
    Color? neutral,
    Color? neutral100,
    Color? neutral200,
    Color? neutral300,
    Color? neutral400,
    Color? neutral500,
    Color? neutral600,
    Color? neutral700,
    Color? neutral800,
    Color? neutral900,
    Color? error100,
    Color? info100,
    List<Color>? colorGraph,
    String? statusBarTheme,
    Images? images,
    CustonIcons? icons,
    ConfigIcon? configIcon,
    LinearGradient? gradient,
    TextStyle? heading1,
    TextStyle? heading2,
    TextStyle? heading3,
    TextStyle? heading4,
    TextStyle? heading5,
    TextStyle? heading6,
    TextStyle? heading1SemiBold,
    TextStyle? heading2SemiBold,
    TextStyle? heading3SemiBold,
    TextStyle? heading4SemiBold,
    TextStyle? heading5SemiBold,
    TextStyle? heading6SemiBold,
    TextStyle? buttonGiant,
    TextStyle? buttonLarge,
    TextStyle? buttonMedium,
    TextStyle? buttonSmall,
    TextStyle? buttonTiny,
    TextStyle? subtitle,
    TextStyle? subtitleMedium,
    TextStyle? subtitleSemiBold,
    TextStyle? labelLarge,
    TextStyle? labelLargeMedium,
    TextStyle? labelLargeSemiBold,
    TextStyle? labelDefault,
    TextStyle? labelDefaultMedium,
    TextStyle? labelDefaultSemiBold,
    TextStyle? labelMedium,
    TextStyle? labelMediumMedium,
    TextStyle? labelMediumSemiBold,
    TextStyle? labelSmall,
    TextStyle? labelSmallMedium,
    TextStyle? labelSmallSemiBold,
    TextStyle? labelTiny,
    TextStyle? labelCaption,
    TextStyle? labelCaptionMedium,
    TextStyle? labelCaptionSemiBold,
    TextStyle? paragraphDefault,
    TextStyle? paragraphDefaultMedium,
    TextStyle? paragraphDefaultSemiBold,
    TextStyle? paragraphMedium,
    TextStyle? paragraphSmall,
    TextStyle? caption,
    TextStyle? overline,
    BitmapDescriptor? mapCarOffIcon,
    BitmapDescriptor? mapMotoOffIcon,
    BitmapDescriptor? mapTruckOffIcon,
    BitmapDescriptor? mapCarOnIcon,
    BitmapDescriptor? mapMotoOnIcon,
    BitmapDescriptor? mapTruckOnIcon,
    BitmapDescriptor? mapRoutePoint,
    BitmapDescriptor? mapFinish,
  }) {
    return AppDesign(
      primary: primary ?? this.primary,
      primary100: primary100 ?? this.primary100,
      primary200: primary200 ?? this.primary200,
      primary300: primary300 ?? this.primary300,
      primary400: primary400 ?? this.primary400,
      primary500: primary500 ?? this.primary500,
      primary600: primary600 ?? this.primary600,
      secondary: secondary ?? this.secondary,
      secondary100: secondary100 ?? this.secondary100,
      secondary200: secondary200 ?? this.secondary200,
      secondary300: secondary300 ?? this.secondary300,
      secondary400: secondary400 ?? this.secondary400,
      secondary500: secondary500 ?? this.secondary500,
      secondary600: secondary600 ?? this.secondary600,
      tertiary100: tertiary100 ?? this.tertiary100,
      tertiary200: tertiary200 ?? this.tertiary200,
      tertiary300: tertiary300 ?? this.tertiary300,
      tertiary400: tertiary400 ?? this.tertiary400,
      tertiary500: tertiary500 ?? this.tertiary500,
      tertiary600: tertiary600 ?? this.tertiary600,
      neutral: neutral ?? this.neutral,
      neutral100: neutral100 ?? this.neutral100,
      neutral200: neutral200 ?? this.neutral200,
      neutral300: neutral300 ?? this.neutral300,
      neutral400: neutral400 ?? this.neutral400,
      neutral500: neutral500 ?? this.neutral500,
      neutral600: neutral600 ?? this.neutral600,
      neutral700: neutral700 ?? this.neutral700,
      neutral800: neutral800 ?? this.neutral800,
      neutral900: neutral900 ?? this.neutral900,
      error100: error100 ?? this.error100,
      info100: info100 ?? this.info100,
      statusBarTheme: statusBarTheme ?? this.statusBarTheme,
      images: images ?? this.images,
      icons: icons ?? this.icons,
      configIcon: configIcon ?? this.configIcon,
      gradient: gradient ?? _gradient,
      heading1: heading1 ?? _heading1,
      heading2: heading2 ?? _heading2,
      heading3: heading3 ?? _heading3,
      heading4: heading4 ?? _heading4,
      heading5: heading5 ?? _heading5,
      heading6: heading6 ?? _heading6,
      heading1SemiBold: heading1SemiBold ?? _heading1SemiBold,
      heading2SemiBold: heading2SemiBold ?? _heading2SemiBold,
      heading3SemiBold: heading3SemiBold ?? _heading3SemiBold,
      heading4SemiBold: heading4SemiBold ?? _heading4SemiBold,
      heading5SemiBold: heading5SemiBold ?? _heading5SemiBold,
      heading6SemiBold: heading6SemiBold ?? _heading6SemiBold,
      buttonGiant: buttonGiant ?? _buttonGiant,
      buttonLarge: buttonLarge ?? _buttonLarge,
      buttonMedium: buttonMedium ?? _buttonMedium,
      buttonSmall: buttonSmall ?? _buttonSmall,
      buttonTiny: buttonTiny ?? _buttonTiny,
      subtitle: subtitle ?? _subtitle,
      subtitleMedium: subtitleMedium ?? _subtitleMedium,
      subtitleSemiBold: subtitleSemiBold ?? _subtitleSemiBold,
      labelLarge: labelLarge ?? _labelLarge,
      labelLargeMedium: labelLargeMedium ?? _labelLargeMedium,
      labelLargeSemiBold: labelLargeSemiBold ?? _labelLargeSemiBold,
      labelDefault: labelDefault ?? _labelDefault,
      labelDefaultMedium: labelDefaultMedium ?? _labelDefaultMedium,
      labelDefaultSemiBold: labelDefaultSemiBold ?? _labelDefaultSemiBold,
      labelMedium: labelMedium ?? _labelMedium,
      labelMediumMedium: labelMediumMedium ?? _labelMediumMedium,
      labelMediumSemiBold: labelMediumSemiBold ?? _labelMediumSemiBold,
      labelSmall: labelSmall ?? _labelSmall,
      labelSmallMedium: labelSmallMedium ?? _labelSmallMedium,
      labelSmallSemiBold: labelSmallSemiBold ?? _labelSmallSemiBold,
      labelCaption: labelCaption ?? _labelCaption,
      labelCaptionMedium: labelCaptionMedium ?? _labelCaptionMedium,
      labelCaptionSemiBold: labelCaptionSemiBold ?? _labelCaptionSemiBold,
      labelTiny: labelTiny ?? _labelTiny,
      paragraphDefault: paragraphDefault ?? _paragraphDefault,
      paragraphDefaultMedium: paragraphDefaultMedium ?? _paragraphDefaultMedium,
      paragraphDefaultSemiBold:
          paragraphDefaultSemiBold ?? _paragraphDefaultSemiBold,
      paragraphMedium: paragraphMedium ?? _paragraphMedium,
      paragraphSmall: paragraphSmall ?? _paragraphSmall,
      caption: caption ?? _caption,
      overline: overline ?? _overline,
      mapCarOffIcon: mapCarOffIcon ?? this.mapCarOffIcon,
      mapMotoOffIcon: mapMotoOffIcon ?? this.mapMotoOffIcon,
      mapTruckOffIcon: mapTruckOffIcon ?? this.mapTruckOffIcon,
      mapCarOnIcon: mapCarOnIcon ?? this.mapCarOnIcon,
      mapMotoOnIcon: mapMotoOnIcon ?? this.mapMotoOnIcon,
      mapTruckOnIcon: mapTruckOnIcon ?? this.mapTruckOnIcon,
      mapRoutePoint: mapRoutePoint ?? this.mapRoutePoint,
      mapFinish: mapFinish ?? this.mapFinish,
    );
  }

  /// [Headings]
  TextStyle h1({Color? color}) => _getStyle(_heading1, color);

  TextStyle h2({Color? color}) => _getStyle(_heading2, color);

  TextStyle h3({Color? color}) => _getStyle(_heading3, color);

  TextStyle h4({Color? color}) => _getStyle(_heading4, color);

  TextStyle h5({Color? color}) => _getStyle(_heading5, color);

  TextStyle h6({Color? color}) => _getStyle(_heading6, color);

  TextStyle h1SemiBold({Color? color}) => _getStyle(_heading1SemiBold, color);

  TextStyle h2SemiBold({Color? color}) => _getStyle(_heading2SemiBold, color);

  TextStyle h3SemiBold({Color? color}) => _getStyle(_heading3SemiBold, color);

  TextStyle h4SemiBold({Color? color}) => _getStyle(_heading4SemiBold, color);

  TextStyle h5SemiBold({Color? color}) => _getStyle(_heading5SemiBold, color);

  TextStyle h6SemiBold({Color? color}) => _getStyle(_heading6SemiBold, color);

  /// [Buttons]
  TextStyle buttonX({Color? color}) => _getStyle(_buttonGiant, color);

  TextStyle buttonL({Color? color}) => _getStyle(_buttonLarge, color);

  TextStyle buttonM({Color? color}) => _getStyle(_buttonMedium, color);

  TextStyle buttonS({Color? color}) => _getStyle(_buttonSmall, color);

  TextStyle buttonXS({Color? color}) => _getStyle(_buttonTiny, color);

  /// [Subtitle, Paragraph, Caption]
  TextStyle subtitle({Color? color}) => _getStyle(_subtitle, color);

  TextStyle subtitleMedium({Color? color}) => _getStyle(_subtitleMedium, color);

  TextStyle subtitleSemiBold({Color? color}) =>
      _getStyle(_subtitleSemiBold, color);

  TextStyle labelL({Color? color}) => _getStyle(_labelLarge, color);

  TextStyle labelLMedium({Color? color}) => _getStyle(_labelLargeMedium, color);

  TextStyle labelLSemiBold({Color? color}) =>
      _getStyle(_labelLargeSemiBold, color);

  TextStyle labelD({Color? color}) => _getStyle(_labelDefault, color);

  TextStyle labelDMedium({Color? color}) =>
      _getStyle(_labelDefaultMedium, color);

  TextStyle labelDSemiBold({Color? color}) =>
      _getStyle(_labelDefaultSemiBold, color);

  TextStyle labelM({Color? color}) => _getStyle(_labelMedium, color);

  TextStyle labelMMedium({Color? color}) =>
      _getStyle(_labelMediumMedium, color);

  TextStyle labelMSemiBold({Color? color}) =>
      _getStyle(_labelMediumSemiBold, color);

  TextStyle labelS({Color? color}) => _getStyle(_labelSmall, color);

  TextStyle labelSMedium({Color? color}) => _getStyle(_labelSmallMedium, color);

  TextStyle labelSSemiBold({Color? color}) =>
      _getStyle(_labelSmallSemiBold, color);

  TextStyle labelC({Color? color}) => _getStyle(_labelCaption, color);

  TextStyle labelCMedium({Color? color}) =>
      _getStyle(_labelCaptionMedium, color);

  TextStyle labelCSemiBold({Color? color}) =>
      _getStyle(_labelCaptionSemiBold, color);

  TextStyle labelXS({Color? color}) => _getStyle(_labelTiny, color);

  TextStyle paragraphD({Color? color}) => _getStyle(_paragraphDefault, color);

  TextStyle paragraphDMedium({Color? color}) =>
      _getStyle(_paragraphDefaultMedium, color);

  TextStyle paragraphDSemiBold({Color? color}) =>
      _getStyle(_paragraphDefaultSemiBold, color);

  TextStyle paragraphM({Color? color}) => _getStyle(_paragraphMedium, color);

  TextStyle paragraphS({Color? color}) => _getStyle(_paragraphSmall, color);

  TextStyle caption({Color? color}) => _getStyle(_caption, color);

  TextStyle overline({Color? color}) => _getStyle(_overline, color);

  /// [Gradient]
  LinearGradient gradient() => _getGradient(_gradient);

  TextStyle _getStyle(TextStyle style, Color? color) {
    return GoogleFonts.getFont(
      style.fontFamily ?? fontFamily,
      fontSize: style.fontSize!.fontSize,
      fontWeight: style.fontWeight,
      height: style.height,
      letterSpacing: style.letterSpacing,
      color: color ?? primary300,
    );
  }

  LinearGradient _getGradient(LinearGradient gradient) {
    return LinearGradient(
      colors: gradient.colors,
      begin: gradient.begin,
      end: gradient.end,
    );
  }

  ThemeData buildThemeData() => ThemeData.from(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primary300,
          secondary: secondary300,
          tertiary: tertiary300,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          error: Colors.black,
          onError: Colors.black,
          background: Colors.black,
          onBackground: Colors.black,
          surface: Colors.black,
          onSurface: Colors.black,
        ),
        textTheme: TextTheme(
          displayLarge: _heading1,
          displayMedium: _heading2,
          displaySmall: _heading3,
          headlineMedium: _heading4,
          headlineSmall: _heading5,
          titleLarge: _heading6,
          labelLarge: _buttonMedium,
          titleMedium: _subtitle,
          titleSmall: _labelMedium,
          bodyLarge: _paragraphMedium,
          bodyMedium: _paragraphSmall,
          bodySmall: _caption,
          labelSmall: _overline,
        ),
      ).copyWith(
        scaffoldBackgroundColor: neutral700,
      );
}

class Images {
  final String logo;
  final String splashLogo;
  final String defaultMap;
  final String hybridMap;
  final String satelliteMap;

  const Images({
    required this.logo,
    required this.splashLogo,
    required this.defaultMap,
    required this.hybridMap,
    required this.satelliteMap,
  });
}

class ConfigIcon {
  final Color colorOn;
  final Color colorOff;
  final double size;
  const ConfigIcon({
    required this.colorOn,
    required this.colorOff,
    required this.size,
  });
}

class CustonIcons {
  final String refresh;
  final String calendar;
  final String car;
  final String filter;
  final String fluentKey;
  final String iconParkOutlineSpeed;
  final String routeSquare;
  final String unlock;
  final String lock;
  final String data;
  final String track;
  final String option;
  final String arrowLeft;
  final String openInNew;
  final String success;
  final String location;
  final String notificationNew;
  final String notification;
  final String user;

  const CustonIcons({
    required this.refresh,
    required this.calendar,
    required this.car,
    required this.filter,
    required this.fluentKey,
    required this.iconParkOutlineSpeed,
    required this.routeSquare,
    required this.unlock,
    required this.lock,
    required this.data,
    required this.track,
    required this.option,
    required this.arrowLeft,
    required this.openInNew,
    required this.success,
    required this.location,
    required this.notificationNew,
    required this.notification,
    required this.user,
  });
}

/// An extension for easily setting the font height for a [TextStyle]
extension FontHeightExtension on TextStyle {
  /// Returns a copy of the [TextStyle] with the calculated font height.
  ///
  /// The value is calculated by dividing the [TextStyle] fontSize and the
  /// passed height value expressed in logica pixels (can be found in Figma).
  ///
  /// Example:
  ///   - fontSize: 32
  ///   - passed height: 36
  ///
  ///   return copyWith(height: 36/32);
  ///
  TextStyle fontHeight(double height) =>
      fontSize == null ? this : copyWith(height: height / fontSize!);
}
