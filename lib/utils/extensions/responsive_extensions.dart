import 'package:flutter/material.dart';

extension ResponsiveExtensions on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
}
