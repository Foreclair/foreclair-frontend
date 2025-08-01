import 'package:flutter/material.dart';

extension SizeUtils on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;

  double get screenWidth => MediaQuery.of(this).size.width;

  double height(double percentage) {
    return screenHeight * percentage / 100;
  }

  double width(double percentage) {
    return screenWidth * percentage / 100;
  }
}
