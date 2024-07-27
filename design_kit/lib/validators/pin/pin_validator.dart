import 'package:flutter/material.dart';

abstract class PinValidator {
  static FormFieldValidator<String> validate({
    required int pinLenght,
  }) {
    return (value) {
      if (value?.isEmpty ?? true) return '';

      if (value!.length != pinLenght) return '';

      return null;
    };
  }
}
