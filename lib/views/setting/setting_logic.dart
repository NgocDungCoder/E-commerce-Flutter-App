import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ecomercy_app_flutter/views/setting/setting_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../services/language_service.dart';

class SettingLogic extends GetxController {
  final state = SettingState();
  final GetStorage storage = GetStorage();
  final languageService = Get.find<LanguageService>();



  @override
  void onInit() {
    super.onInit();
    state.currentLocale.value = languageService.getLocale();
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

  void toggleLanguage() {
    final newLocale = state.currentLocale.value.languageCode == 'en' ? const Locale('vi') : const Locale('en');
    state.currentLocale.value = newLocale;
    languageService.changeLanguage(newLocale);
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