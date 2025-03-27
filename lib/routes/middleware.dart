import 'package:ecomercy_app_flutter/routes/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

final List<SpecialRoute> privateRoutes = <RoutePath>[
  Routes.products,
].map((a) => SpecialRoute(a.p)).toList();

//Hiện giờ chưa hoạt động vì chưa có phần tử
final List<SpecialRoute> routesRequiredConnected = <RoutePath>[]
    .map((e) => SpecialRoute(e.p, requiredConnected: true))
    .toList();

class AuthMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  //redirect() được gọi TỰ ĐỘNG bởi GetX mỗi khi một route được định tuyến.
  RouteSettings? redirect(String? route) {
    print('Checking auth guard...');
    final auth =
        Get.isRegistered<AuthController>() ? Get.find<AuthController>() : null;
    if (auth?.isAuth == true || route == Routes.login.p) return null;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.offAllNamed(
        Routes.login.p,
        parameters: {
          'redirect': route ?? Routes.main.p,
        },
      );
    });
    return RouteSettings(name: Routes.unauthenticated.p);
  }
}

//RouteService giúp theo dõi route hiện tại và route trước đó trong GetX.
class RouteService extends GetxService {
  static RouteService get to => Get.find();

  final RxString _currentRoute = ''.obs;
  final RxString _previousRoute = ''.obs;

  String get currentRoute => _currentRoute.value;
  String get previousRoute => _previousRoute.value;

  void updateRoute(String newRoute) {
    _previousRoute.value = _currentRoute.value;
    _currentRoute.value = newRoute;
  }
}

//Extension GetPageX mở rộng class GetPage
extension GetPageX on GetPage {
  GetPage applyMiddleware() {
    final auth = privateRoutes.firstWhereOrNull((r) => r.route.endsWith(name));
    if(auth != null) {
      return copy(
        middlewares: [
          AuthMiddleWare(),
        ],
        children: children.map((e) => e.applyMiddleware()).toList(),
      );
    }
    return this;
  }
}
