import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeService extends GetxController {
  final isDark = false.obs;

  void switchTheme(bool value) {
    isDark.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }
}
