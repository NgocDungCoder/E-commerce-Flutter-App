import 'package:flutter/material.dart';
import 'app_style.dart';
export 'app_style.dart';

class ThemeConfigs {
  static const Color primary = Color(0xFF0A79DF);
  static const Color secondary = Color(0xFF1B9CFC);
  static const Color background = Color(0xFFF5F6FA);
  static const Color text = Color(0xFF000000);
  static const Color whiteText = Color(0xFFF5F6FA);
  static const Color success = Color(0xFF20BF6B);
  static const Color redText = Color(0xFFE74C3C);
  static const Color border = Color(0xFF000000);

  static Color textPrimary(BuildContext context) => Theme.of(context).colorScheme.onSurface;
  static Color textSecondary(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? Colors.grey[400]!  // Dark mode → Xám nhạt
        : Colors.grey[700]!; // Light mode → Xám đậm
  }
  static Color textHint(BuildContext context) => Theme.of(context).colorScheme.onSurface.withOpacity(0.4);

  // Light Theme
  static const lightPrimary = Color(0xFFF1EFEC);
  static const lightBackground = Colors.white;
  static const lightText = Colors.black;

  // Dark Theme
  static const darkPrimary = Color(0xFF7E99A3);
  static const darkBackground = Color(0xFF4C585B);
  static const darkText = Colors.white;
}

