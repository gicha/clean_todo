import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static final theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: AppColors.primary,
  );
}
