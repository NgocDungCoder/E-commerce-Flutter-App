import 'dart:async';

import 'package:ecomercy_app_flutter/services/init_service.dart';
import 'package:ecomercy_app_flutter/views/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/init_controller.dart';
import 'firebase_options.dart';

void main() async {
  await runZonedGuarded<Future<void>>(() async { //Chạy ứng dụng trong một zone có bắt lỗi toàn cục.
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await initServices();
    await initControllers();

    runApp(MyApp());
  }, (error, stack) async {
    print(error);
    print(stack);

  });
}

