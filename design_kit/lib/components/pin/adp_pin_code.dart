// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../design_kit.dart';
import '../../validators/pin/pin_validator.dart';

class ADPPinCode extends StatefulWidget {
  final int pinLength;

  final bool obsecureText;

  final double fieldWidth;

  final ValueChanged<String> onChanged;

  final bool hasError;

  final String errorMessage;

  final bool loading;

  final VoidCallback onClear;

  const ADPPinCode({
    super.key,
    this.obsecureText = false,
    this.pinLength = 6,
    this.fieldWidth = 50.0,
    required this.onChanged,
    required this.hasError,
    this.loading = false,
    required this.onClear,
    required this.errorMessage,
  });
  @override
  _ADPPinCodeState createState() => _ADPPinCodeState();
}

class _ADPPinCodeState extends State<ADPPinCode> {
  late TextEditingController _controller;

  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _focusNode = FocusNode();

    _controller.addListener(_listener);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller
      ..removeListener(_listener)
      ..dispose();
    super.dispose();
  }

  void _listener() {
    if (mounted) {
      setState(() {
        if (_controller.text.length == widget.pinLength) {
          widget.onChanged(_controller.text);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);

    final double screenWidth = MediaQuery.of(context).size.width - 50.0;
    double fieldWidth = (screenWidth / widget.pinLength) - 10;
    if (fieldWidth > widget.fieldWidth) fieldWidth = widget.fieldWidth;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Offstage(
          child: TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            autofocus: true,
            maxLength: widget.pinLength,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            readOnly: widget.loading,
            validator: PinValidator.validate(pinLenght: widget.pinLength),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            final isKeyboardOpen = View.of(context).viewInsets.bottom > 0;
            if (isKeyboardOpen) {
              FocusScope.of(context).requestFocus(_focusNode);
            } else {
              _focusNode.unfocus();
              await Future<void>.delayed(const Duration(milliseconds: 1));
              FocusScope.of(context).requestFocus(_focusNode);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              widget.pinLength,
              (index) => Flexible(
                child: _CodeInput(
                  key: Key('otp_field_$index'),
                  width: fieldWidth,
                  value: _getCharachterAt(index),
                  obsecureText: widget.obsecureText,
                  isActive: _isActive(index),
                  hasError: widget.hasError,
                  loading: widget.loading,
                ),
              ),
              growable: false,
            ),
          ),
        ),
        if (widget.hasError) ...[
          SizedBox(
            height: 8.0.height,
          ),
          Text(
            widget.errorMessage,
            style: design.caption(color: design.error100),
          ),
        ],
      ],
    );
  }

  String _getCharachterAt(int index) {
    if (_controller.text.isEmpty) return '';
    if (_controller.text.length <= index) return '';

    if (_controller.text.length == widget.pinLength - 1 && widget.hasError) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _controller.clear());

      widget.onClear();
      return '';
    }

    return _controller.text[index];
  }

  bool _isActive(int index) {
    return _controller.selection.baseOffset == index ||
        (_controller.selection.baseOffset > index && index == widget.pinLength);
  }
}

class _CodeInput extends StatefulWidget {
  final String value;

  final double width;

  final bool obsecureText;

  final bool isActive;

  final bool hasError;

  final bool loading;

  const _CodeInput({
    super.key,
    required this.value,
    required this.width,
    required this.obsecureText,
    required this.isActive,
    required this.hasError,
    required this.loading,
  });

  @override
  __CodeInputState createState() => __CodeInputState();
}

class __CodeInputState extends State<_CodeInput> {
  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.width),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: double.infinity,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: widget.width,
          height: widget.width + 2.0,
          decoration: BoxDecoration(
            color: widget.loading
                ? design.neutral.withOpacity(0.15)
                : design.neutral500,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              width: 1.0,
              color: _borderStateColorIndicator(),
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: Center(
            child: widget.obsecureText && widget.value.isNotEmpty
                ? Container(
                    width: widget.width * 0.25,
                    height: widget.width * 0.25,
                    decoration: BoxDecoration(
                      color: design.primary,
                      shape: BoxShape.circle,
                    ),
                  )
                : Text(
                    widget.isActive ? '|' : widget.value,
                    style: design
                        .labelM(
                          color: widget.isActive
                              ? design.neutral300
                              : design.neutral,
                        )
                        .copyWith(
                          fontWeight: widget.isActive ? FontWeight.w600 : null,
                        ),
                  ),
          ),
        ),
      ),
    );
  }

  Color _borderStateColorIndicator() {
    final design = DesignSystem.of(context);

    if (widget.hasError) {
      return design.error100;
    }

    if (widget.isActive) {
      return design.primary;
    }

    return design.neutral.withOpacity(0.15);
  }
}
