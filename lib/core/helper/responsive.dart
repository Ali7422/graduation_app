import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  double h(double percentage) => height * percentage;
  double w(double percentage) => width * percentage;
}
