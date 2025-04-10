import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ecomercy_app_flutter/routes/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '';
import 'package:get/get.dart';
import '../configs/styles/themes/themes.dart';
import '../generated/l10n.dart';

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  MyApp({super.key, this.savedThemeMode});

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => GetMaterialApp(
        key: _navigatorKey,
        smartManagement: SmartManagement.full,
        initialRoute: Routes.splash.p,
        getPages: getPages,
        debugShowCheckedModeBanner: false,
        title: 'E-commerce',
        theme: theme,
        darkTheme: darkTheme,
        enableLog: kDebugMode,
        themeMode: ThemeMode.system,
        popGesture: !kIsWeb,
        defaultTransition: kIsWeb ? Transition.fadeIn : Transition.cupertino,
        onInit: () {
          // ExceptionHandler.instance.loaded();
        },
        locale: const Locale('en'), //Ngôn ngữ hiện tại app lấy
        // fallbackLocale: const Locale('en'), //Nếu device không hỗ trợ → fallback qua ngôn ngữ này
        localizationsDelegates: const [
          S.delegate, // Text trong app
          GlobalMaterialLocalizations.delegate, // Text của Material UI
          GlobalWidgetsLocalizations.delegate, // Hỗ trợ LTR, RTL
          GlobalCupertinoLocalizations.delegate, // Text của Cupertino UI
        ], //	Load resource đa ngôn ngữ
        supportedLocales: S.delegate.supportedLocales, //	Danh sách ngôn ngữ app hỗ trợ

      ),
    );
  }
}
