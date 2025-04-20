import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageService extends GetxService {
  final _storage = GetStorage();
  final localeKey = 'locale';

  Locale getLocale() {
    final langCode = _storage.read(localeKey) ?? 'en';
    return Locale(langCode);
  }

  void changeLanguage(Locale locale) {
    Get.updateLocale(locale);
    _storage.write(localeKey, locale.languageCode);
  }
}