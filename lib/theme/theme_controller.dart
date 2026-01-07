import 'package:flutter/material.dart';

class ThemeController {
  static ValueNotifier<ThemeMode> themeMode =
      ValueNotifier(ThemeMode.light);
}
