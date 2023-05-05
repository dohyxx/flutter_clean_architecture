import 'package:flutter/material.dart';

class UtilColors {
  UtilColors._();

  static const primaryColor = MaterialColor(
    _mainPrimaryValue,
    <int, Color>{
      50: Color(_mainPrimaryValue),
      100: Color(_mainPrimaryValue),
      200: Color(_mainPrimaryValue),
      300: Color(_mainPrimaryValue),
      400: Color(_mainPrimaryValue),
      500: Color(_mainPrimaryValue),
    },
  );

  static const int _mainPrimaryValue = 0xFF20252a;
}
