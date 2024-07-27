import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../design_kit.dart';

class ADPTextFormField extends FormField<String> {
  final BuildContext context;
  final String hint;
  final String label;
  final String? initialText;
  final String optionalText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final bool enable;
  final bool autofocus;
  final bool obscureText;
  final VoidCallback? toggleObscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validators;
  final TextInputType formFieldType;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final Function(String)? onChanged;
  final Color? fillColor;
  final AutovalidateMode validateMode;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool loading;

  ADPTextFormField(
    this.context, {
    super.key,
    this.hint = '',
    this.label = '',
    this.initialText,
    this.optionalText = '',
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.enable = true,
    this.autofocus = false,
    this.obscureText = false,
    this.toggleObscureText,
    this.controller,
    this.validators,
    this.formFieldType = TextInputType.text,
    this.onTap,
    this.onEditingComplete,
    this.onChanged,
    this.fillColor,
    this.validateMode = AutovalidateMode.onUserInteraction,
    this.inputFormatters,
    this.focusNode,
    this.loading = false,
  }) : super(
          builder: (field) {
            final design = DesignSystem.of(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: hint.isNotEmpty || optionalText.isNotEmpty,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            hint,
                            style: design.labelS(color: design.neutral),
                          ),
                          Text(
                            optionalText,
                            style: design.overline(color: design.neutral300),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        focusNode: focusNode,
                        inputFormatters: inputFormatters,
                        controller: controller,
                        initialValue: initialText,
                        enabled: enable,
                        keyboardType: formFieldType,
                        obscureText: obscureText,
                        autovalidateMode: validateMode,
                        validator: validators,
                        onTap: onTap,
                        onEditingComplete: onEditingComplete,
                        onChanged: onChanged,
                        autofocus: autofocus,
                        maxLines: maxLines,
                        maxLength: maxLength,
                        cursorColor: design.neutral,
                        style: design.labelM(
                          color: design.neutral,
                        ),
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: fillColor != null || !enable,
                          labelText: label,
                          labelStyle: design.labelM(color: design.neutral300),
                          errorStyle: design.caption(
                            color: design.error100,
                          ),
                          fillColor: !enable
                              ? fillColor ?? design.neutral800.withOpacity(.5)
                              : fillColor,
                          prefixIcon: prefixIcon,
                          suffixIcon: toggleObscureText != null
                              ? suffixIcon ??
                                  _hiddenTextIcon(
                                    design,
                                    isObscure: obscureText,
                                    onTap: toggleObscureText,
                                  )
                              : suffixIcon,
                          enabledBorder: _borderStyle(
                            design,
                          ),
                          disabledBorder: _borderStyle(
                            design,
                          ),
                          focusedBorder: _borderStyle(
                            design,
                            isFocused: true,
                          ),
                          errorBorder: _borderStyle(
                            design,
                            isError: true,
                          ),
                          focusedErrorBorder: _borderStyle(
                            design,
                            isError: true,
                          ),
                        ),
                      ),
                    ),
                    if (loading) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.0.width,
                        ),
                        child: const ADPCircularProgress(
                          size: 30.0,
                          strokeWidth: 4,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            );
          },
        );

  @override
  _ADPTextFormFieldState createState() => _ADPTextFormFieldState();
}

InkWell _hiddenTextIcon(
  AppDesign design, {
  required bool isObscure,
  required VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(50),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 400),
          crossFadeState:
              isObscure ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: Icon(
            Icons.visibility_outlined,
            color: design.neutral200,
          ),
          secondChild: Icon(
            Icons.visibility_off_outlined,
            color: design.neutral200,
          ),
        ),
      ],
    ),
  );
}

InputBorder _borderStyle(
  AppDesign design, {
  bool isError = false,
  bool isFocused = false,
}) {
  var borderColor = isError
      ? design.error100
      : isFocused
          ? design.primary
          : design.neutral300;

  return UnderlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(
      width: 1.5,
      color: borderColor,
    ),
  );
}

class _ADPTextFormFieldState extends FormFieldState<String> {
  TextEditingController? get _effectiveController => widget.controller;

  @override
  ADPTextFormField get widget => super.widget as ADPTextFormField;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_handleControllerChanged);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void didUpdateWidget(ADPTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      setValue(widget.controller?.text);
    }
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (_effectiveController!.text != value) {
      _effectiveController!.text = value!;
    }
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController!.text = widget.initialValue!;
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController!.text != value) {
      didChange(_effectiveController!.text);
    }
  }
}
