import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ecomercy_app_flutter/views/setting/setting_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingLogic extends GetxController {
  final state = SettingState();
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    initTheme();
  }

  Future<void> initTheme() async {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();

    if (savedThemeMode != null) {
      state.isDarkMode.value = savedThemeMode == AdaptiveThemeMode.dark;
    } else {
      final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      state.isDarkMode.value = brightness == Brightness.dark;
    }
  }

    // GetX observable

  void toggleDarkMode(bool value) {
    state.isDarkMode.value = value;

    if (value) {
      AdaptiveTheme.of(Get.context!).setDark();
    } else {
      AdaptiveTheme.of(Get.context!).setLight();
    }

  }

}