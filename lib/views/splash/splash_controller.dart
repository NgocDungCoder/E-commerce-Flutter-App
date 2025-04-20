import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../routes/route.dart';

class SplashController extends GetxController {
  Future startApp() async {
    // Sau khi Future hoàn thành, chạy đoạn code bên trong { ... }.
    // _ nghĩa là không quan tâm đến giá trị trả về của initControllers()

    if (Get.find<AuthController>().isAuth) {
      Get.offNamed(Routes.products.p);
    } else {
      Get.offNamed(Routes.login.p);
    }
  }
}
