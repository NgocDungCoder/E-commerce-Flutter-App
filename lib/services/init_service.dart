import 'package:ecomercy_app_flutter/services/connectivity_service.dart';
import 'package:ecomercy_app_flutter/services/product_service.dart';
import 'package:ecomercy_app_flutter/services/secure_storage_service.dart';
import 'package:ecomercy_app_flutter/services/storage_service.dart';
import 'package:ecomercy_app_flutter/services/theme_service.dart';
import 'package:get/get.dart';

import '../routes/middleware.dart';
import 'noti_service.dart';
import 'notificaton_service.dart';

Future initServices() async {
  Get.put(RouteService()); //middleware
  Get.put(ConnectivityService());
  Get.put(ThemeService());
  Get.put(ProductService());
  await Get.putAsync(() => StorageService().init());
  await Get.putAsync(() => SecureStorageService().init());
  NotiService().initNotification();
  await NotificationService.instance.initialize();
}
