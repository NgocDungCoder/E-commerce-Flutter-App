import 'package:ecomercy_app_flutter/services/connectivity_service.dart';
import 'package:ecomercy_app_flutter/services/product_service.dart';
import 'package:ecomercy_app_flutter/services/secure_storage_service.dart';
import 'package:ecomercy_app_flutter/services/storage_service.dart';
import 'package:get/get.dart';

import '../routes/middleware.dart';

Future initServices() async {
  Get.put(RouteService()); //middleware
  Get.put(ConnectivityService());
  Get.put(ProductService());
  await Get.putAsync(() => StorageService().init());
  await Get.putAsync(() => SecureStorageService().init());
}
