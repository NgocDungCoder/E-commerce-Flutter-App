import 'package:ecomercy_app_flutter/routes/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _navigatorKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      key: _navigatorKey,
      smartManagement: SmartManagement.full,
      initialRoute: Routes.splash.p,
      getPages: getPages,
      debugShowCheckedModeBanner: false,
      title: 'E-commerce',
      enableLog: kDebugMode,
      popGesture: !kIsWeb,
      defaultTransition: kIsWeb ? Transition.fadeIn : Transition.cupertino,
      onInit: () {
        // ExceptionHandler.instance.loaded();
      },
      locale: const Locale('en'),
    );
  }
}
