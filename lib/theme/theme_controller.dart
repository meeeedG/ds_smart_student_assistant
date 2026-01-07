import 'package:flutter/material.dart';

/// Contrôleur simple pour gérer le thème de l'application
class ThemeController {
  // ValueNotifier permet de notifier l'application
  // lorsqu'il y a un changement de thème
  static ValueNotifier<ThemeMode> themeMode =
      ValueNotifier(ThemeMode.light);
}
