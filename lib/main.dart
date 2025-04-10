import 'dart:async';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ecomercy_app_flutter/services/init_service.dart';
import 'package:ecomercy_app_flutter/services/noti_service.dart';
import 'package:ecomercy_app_flutter/services/notificaton_service.dart';
import 'package:ecomercy_app_flutter/utils/widget_binding_utils.dart';
import 'package:ecomercy_app_flutter/views/app.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'controllers/init_controller.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';


void main() async {
  await runZonedGuarded<Future<void>>(() async { //Chạy ứng dụng trong một zone có bắt lỗi toàn cục.
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await initDeepLink();
    await initServices();
    await initControllers();


    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    runApp(MyApp(savedThemeMode: savedThemeMode));
  }, (error, stack) async {
    print(error);
    print(stack);

  });
}

Future<void> initDeepLink() async {
  final appLinks = AppLinks();
  appLinks.uriLinkStream.listen((uri) async {
    // Do something (navigation, ...)
    await WidgetsBindingUtils.waitForPostFrame();
    if (uri.scheme.contains('http')) {
      print('=>>>[AppLinks Listener]>>>>$uri');
      Get.toNamed(uri.fragment);
    } else {
      print('=>>>[DeepLink Listener]>>>>$uri');
      Get.toNamed(uri.path);
    }
  });
}


