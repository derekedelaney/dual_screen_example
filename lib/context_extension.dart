import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  bool get isSmallScreen => MediaQuery.of(this).size.width < 600;
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;
  double get paneProportion => isPortrait ? 0.43 : 0.33;
}
