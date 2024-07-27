import 'package:flutter/material.dart';

import '../../design_kit.dart';

class ADPPasswordRules extends StatefulWidget {
  final TextEditingController controller;

  final TextEditingController? confirmController;

  final TextStyle? rulesStyle;

  final Color? approvedColor;

  final Color? refusedColor;

  final int minimum;

  final int maximum;

  final bool hasUpperCaseCharacter;

  final bool hasLowerCaseCharacter;

  final bool hasNumberCharacter;

  final bool hasSpecialCharacter;

  final ValueChanged<bool> onChanged;

  final String title;

  final String labelMinimum;

  final String labelMaximum;

  final String labelHasUpperCase;

  final String labelHasLowerCase;

  final String labelHasNumber;

  final String labelHasSpecialCharacter;

  final String labelRepeatPassword;

  final bool displayBackground;

  const ADPPasswordRules({
    super.key,
    required this.controller,
    this.confirmController,
    this.rulesStyle,
    this.approvedColor,
    this.refusedColor,
    this.minimum = 10,
    this.hasUpperCaseCharacter = true,
    this.hasLowerCaseCharacter = true,
    this.hasNumberCharacter = true,
    this.hasSpecialCharacter = true,
    required this.onChanged,
    required this.title,
    required this.labelMinimum,
    required this.labelMaximum,
    required this.labelHasUpperCase,
    required this.labelHasLowerCase,
    required this.labelHasNumber,
    required this.labelHasSpecialCharacter,
    required this.labelRepeatPassword,
    this.displayBackground = true,
    this.maximum = 16,
  });

  @override
  State<ADPPasswordRules> createState() => _ADPPasswordRulesState();
}

class _ADPPasswordRulesState extends State<ADPPasswordRules> {
  List<bool Function()> rules = [];

  @override
  void initState() {
    super.initState();
    _getRules();

    widget.controller.addListener(_listener);
    widget.confirmController?.addListener(_listener);
  }

  @override
  void dispose() {
    try {
      widget.controller.dispose();
      widget.confirmController?.dispose();
      widget.controller.removeListener(_listener);
      widget.confirmController?.removeListener(_listener);
    } catch (e) {
      debugPrint('DISPOSE ==>: ${e.toString()}');
    }

    super.dispose();
  }

  void _listener() => widget.onChanged(_validate());

  bool _hasMinimumDigits(String value) {
    return value.length >= widget.minimum;
  }

  bool _hasMaximumDigits(String value) {
    return value.length <= widget.maximum;
  }

  bool _hasUpperCaseCharacter(String value) {
    final regex = RegExp(r'(?=.*[A-Z])');
    return regex.hasMatch(value);
  }

  bool _hasLowerCaseCharacter(String value) {
    final regex = RegExp(r'(?=.*[a-z])');
    return regex.hasMatch(value);
  }

  bool _hasNumberCharacter(String value) {
    final regex = RegExp(r'(?=.*\d)');
    return regex.hasMatch(value);
  }

  bool _hasSpecialCharacter(String value) {
    final regex = RegExp(r'(?=.*[/\W|_/])');
    return regex.hasMatch(value);
  }

  bool _comparePasswords(String value) {
    final passwordCompare = widget.confirmController?.text ?? '';
    return passwordCompare == value;
  }

  void _getRules() {
    rules
      ..add(() => _hasMinimumDigits(widget.controller.text))
      ..add(() => _hasMaximumDigits(widget.controller.text));

    if (widget.hasUpperCaseCharacter) {
      rules.add(() => _hasUpperCaseCharacter(widget.controller.text));
    }
    if (widget.hasLowerCaseCharacter) {
      rules.add(() => _hasLowerCaseCharacter(widget.controller.text));
    }
    if (widget.hasNumberCharacter) {
      rules.add(() => _hasNumberCharacter(widget.controller.text));
    }
    if (widget.hasSpecialCharacter) {
      rules.add(() => _hasSpecialCharacter(widget.controller.text));
    }
    if (widget.confirmController != null) {
      rules.add(() => _comparePasswords(widget.controller.text));
    }
  }

  bool _validate() {
    for (final validator in rules) {
      if (!validator()) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final passwordText = widget.controller.text;
    final design = DesignSystem.of(context);

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color:
            widget.displayBackground ? design.neutral500 : Colors.transparent,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: design.buttonS(color: design.neutral200),
          ),
          SizedBox(height: 6.0.height),
          _RuleWidget(
            isValid: _hasMinimumDigits(passwordText),
            label: widget.labelMinimum,
            rulesStyle: widget.rulesStyle,
            approvedColor: widget.approvedColor,
            refusedColor: widget.refusedColor,
          ),
          _RuleWidget(
            isValid: _hasMaximumDigits(passwordText),
            label: widget.labelMaximum,
            rulesStyle: widget.rulesStyle,
            approvedColor: widget.approvedColor,
            refusedColor: widget.refusedColor,
          ),
          Visibility(
            visible: widget.hasUpperCaseCharacter,
            child: _RuleWidget(
              isValid: _hasUpperCaseCharacter(passwordText),
              label: widget.labelHasUpperCase,
              rulesStyle: widget.rulesStyle,
              approvedColor: widget.approvedColor,
              refusedColor: widget.refusedColor,
            ),
          ),
          Visibility(
            visible: widget.hasLowerCaseCharacter,
            child: _RuleWidget(
              isValid: _hasLowerCaseCharacter(passwordText),
              label: widget.labelHasLowerCase,
              rulesStyle: widget.rulesStyle,
              approvedColor: widget.approvedColor,
              refusedColor: widget.refusedColor,
            ),
          ),
          Visibility(
            visible: widget.hasSpecialCharacter,
            child: _RuleWidget(
              isValid: _hasSpecialCharacter(passwordText),
              label: widget.labelHasSpecialCharacter,
              rulesStyle: widget.rulesStyle,
              approvedColor: widget.approvedColor,
              refusedColor: widget.refusedColor,
            ),
          ),
          Visibility(
            visible: widget.hasNumberCharacter,
            child: _RuleWidget(
              isValid: _hasNumberCharacter(passwordText),
              label: widget.labelHasNumber,
              rulesStyle: widget.rulesStyle,
              approvedColor: widget.approvedColor,
              refusedColor: widget.refusedColor,
            ),
          ),
          Visibility(
            visible: widget.confirmController != null,
            child: _RuleWidget(
              isValid: _comparePasswords(passwordText),
              label: widget.labelRepeatPassword,
              rulesStyle: widget.rulesStyle,
              approvedColor: widget.approvedColor,
              refusedColor: widget.refusedColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _RuleWidget extends StatelessWidget {
  final bool isValid;

  final String label;

  final TextStyle? rulesStyle;

  final Color? approvedColor;

  final Color? refusedColor;

  const _RuleWidget({
    required this.isValid,
    required this.label,
    this.rulesStyle,
    this.approvedColor,
    this.refusedColor,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);

    final color = _getColorByRules(context, isValid: isValid);

    return Padding(
      padding: EdgeInsets.only(top: 5.height),
      child: Row(
        children: [
          SvgPicture.asset(
            isValid ? AppIcons.checkIcon : AppIcons.closeIcon,
            colorFilter: ColorFilter.mode(
              color,
              BlendMode.srcIn,
            ),
            width: 16.0.fontSize,
          ),
          SizedBox(width: 7.width),
          Text(
            label,
            style: rulesStyle ??
                design.buttonS(
                  color: design.neutral200,
                ),
          ),
        ],
      ),
    );
  }

  Color _getColorByRules(BuildContext context, {required bool isValid}) {
    final design = DesignSystem.of(context);
    return isValid
        ? approvedColor ?? design.secondary
        : refusedColor ?? design.error100;
  }
}
