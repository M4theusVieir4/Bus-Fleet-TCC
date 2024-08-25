import 'package:flutter/material.dart';

import '../../design_kit.dart';

enum ADPBottomSheetType { accept, info }

abstract class ADPBottomSheet {
  static void showContent({
    required BuildContext context,
    required Widget content,
    bool enableDrag = true,
    bool isDismissible = true,
    bool useRootNavigator = false,
    String actionLabel = '',
    Color? backgroundColor,
    CrossAxisAlignment? alignment,
    VoidCallback? onAction,
  }) {
    final design = DesignSystem.of(context);
    showModalBottomSheet(
      backgroundColor: backgroundColor ?? design.neutral900,
      enableDrag: enableDrag,
      useRootNavigator: useRootNavigator,
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0.height),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: _slider(design.neutral500),
            ),
            content,
          ],
        ),
      ),
    );
  }

  static void success({
    required BuildContext context,
    required String title,
    required String actionMessage,
    required String message,
    VoidCallback? onAction,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    show(
      context: context,
      type: ADPBottomSheetType.accept,
      title: title,
      message: message,
      actionMessage: actionMessage,
      textAlign: TextAlign.center,
      onAction: onAction,
      icon: SvgPicture.asset(AppIcons.successIcon),
      isDismissible: isDismissible,
      enableDrag: enableDrag,
    );
  }

  static void warning({
    required BuildContext context,
    required String title,
    required String actionMessage,
    required String message,
    VoidCallback? onAction,
  }) {
    show(
      context: context,
      type: ADPBottomSheetType.accept,
      title: title,
      message: message,
      actionMessage: actionMessage,
      textAlign: TextAlign.center,
      isError: true,
      onAction: onAction,
      icon: SvgPicture.asset(AppIcons.warningIcon),
    );
  }

  static void error({
    required BuildContext context,
    required String title,
    required String actionMessage,
    required String message,
    VoidCallback? onAction,
  }) {
    show(
      context: context,
      type: ADPBottomSheetType.accept,
      title: title,
      message: message,
      actionMessage: actionMessage,
      textAlign: TextAlign.center,
      isError: true,
      onAction: onAction,
      icon: SvgPicture.asset(AppIcons.errorIcon),
    );
  }

  static void show({
    required BuildContext context,
    required ADPBottomSheetType type,
    required String title,
    String? message,
    required String actionMessage,
    VoidCallback? onAction,
    VoidCallback? onBack,
    String backMessage = '',
    bool isDismissible = true,
    bool enableDrag = true,
    bool isError = false,
    bool useRootNavigator = false,
    Color? backgroundColor,
    Widget? icon,
    Widget? content,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextAlign textAlign = TextAlign.start,
    double? fontSize,
  }) =>
      _baseBottomSheet(
        context: context,
        type: type,
        title: title,
        message: message,
        actionMessage: actionMessage,
        backMessage: backMessage,
        onAction: onAction,
        onBack: onBack,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        icon: icon,
        content: content,
        isError: isError,
        useRootNavigator: useRootNavigator,
        backgroundColor: backgroundColor,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        textAlign: textAlign,
        fontSize: fontSize,
      );

  static void _baseBottomSheet({
    required BuildContext context,
    required ADPBottomSheetType type,
    required String title,
    String? message,
    required String backMessage,
    required bool? isDismissible,
    required bool? enableDrag,
    required String actionMessage,
    bool isError = false,
    bool useRootNavigator = false,
    Color? backgroundColor,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextAlign textAlign = TextAlign.start,
    Widget? content,
    Widget? icon,
    VoidCallback? onAction,
    VoidCallback? onBack,
    double? fontSize,
  }) {
    final size = MediaQuery.of(context).size;

    final design = DesignSystem.of(context);

    showModalBottomSheet(
      useRootNavigator: useRootNavigator,
      isScrollControlled: true,
      isDismissible: isDismissible!,
      enableDrag: enableDrag!,
      backgroundColor: backgroundColor ?? design.neutral900,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      context: context,
      builder: (_) {
        final color = design.neutral900;
        return WillPopScope(
          onWillPop: () async => isDismissible && enableDrag,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32.0.width),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(.3),
                  blurRadius: 12,
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: mainAxisAlignment,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16.height),
                _slider(design.neutral400),
                Container(
                  constraints: BoxConstraints(maxHeight: size.height * .8),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: mainAxisAlignment,
                      crossAxisAlignment: crossAxisAlignment,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          SizedBox(height: 27.height),
                          icon,
                        ],
                        SizedBox(height: 24.height),
                        Text(
                          title,
                          textAlign: textAlign,
                          style: design
                              .h5(color: design.neutral200)
                              .copyWith(fontSize: fontSize?.fontSize),
                        ),
                        SizedBox(height: 8.height),
                        if (message != null)
                          Text(
                            message,
                            textAlign: textAlign,
                            style: design.paragraphS(
                              color: design.neutral200,
                            ),
                          ),
                        if (content != null) content,
                        SizedBox(height: 16.height),
                        _renderButtons(
                          type: type,
                          labelColor:
                              isError ? design.neutral : design.neutral900,
                          context: context,
                          backMessage: backMessage,
                          actionMessage: actionMessage,
                          isError: isError,
                          onAction: onAction,
                          onBack: onBack,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _renderButtons({
  required ADPBottomSheetType type,
  required BuildContext context,
  required String backMessage,
  required Color labelColor,
  required String actionMessage,
  bool isError = false,
  VoidCallback? onAction,
  VoidCallback? onBack,
}) {
  final design = DesignSystem.of(context);

  return Visibility(
    visible: type == ADPBottomSheetType.info,
    replacement: Padding(
      padding: EdgeInsets.only(bottom: 40.0.height),
      child: ADPDefaultButton(
        labelStyle: design.buttonL(color: design.secondary),
        label: actionMessage,
        primaryColor: design.tertiary100,
        outline: isError,
        onPressed: onAction ?? Navigator.of(context).pop,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.only(bottom: 40.0.height),
      child: Column(
        children: [
          ADPDefaultButton(
            labelStyle: design.buttonL(color: design.neutral500),
            label: actionMessage,
            onPressed: onAction ?? Navigator.of(context).pop,
          ),
          Visibility(
            visible: backMessage.isNotEmpty,
            child: Column(
              children: [
                SizedBox(height: 16.0.height),
                ADPDefaultButton(
                  labelStyle: design.buttonL(color: design.neutral),
                  label: backMessage,
                  outline: true,
                  onPressed: onBack ?? Navigator.of(context).pop,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Container _slider(Color color) {
  return Container(
    height: 5,
    width: 48,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
    ),
  );
}
