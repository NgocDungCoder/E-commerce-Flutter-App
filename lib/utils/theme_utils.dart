import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class ThemeUtils {
  static Future<void> switchTheme(BuildContext context) async {
    final mode = await AdaptiveTheme.getThemeMode();

    if (mode == AdaptiveThemeMode.dark) {
      AdaptiveTheme.of(context).setLight();
    } else {
      AdaptiveTheme.of(context).setDark();
    }
  }
}

// IconButton(
// icon: Icon(
// AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
// ? Icons.light_mode
//     : Icons.dark_mode,
// ),
// onPressed: () => ThemeUtils.switchTheme(context),
// )
