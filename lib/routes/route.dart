import 'package:ecomercy_app_flutter/views/blog/blog_binding.dart';
import 'package:ecomercy_app_flutter/views/blog/blog_view.dart';
import 'package:ecomercy_app_flutter/views/cart/cart_view.dart';
import 'package:ecomercy_app_flutter/views/login/login_screen.dart';
import 'package:ecomercy_app_flutter/views/product_detail/product_detail_binding.dart';
import 'package:ecomercy_app_flutter/views/product_detail/product_detail_screen.dart';
import 'package:ecomercy_app_flutter/views/products/products_screen.dart';
import 'package:ecomercy_app_flutter/views/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../views/home_page/home_screen.dart';
import '../views/products/product_binding.dart';

class RoutePath {
  final String singlePath;
  final RoutePath? parent;

  String get path => parent != null
      ? '${parent != null ? parent!.path : ''}$singlePath'
      : singlePath;

  String get p => path;

  String get sp => singlePath;

  const RoutePath(this.singlePath, {this.parent});

  @override
  String toString() => path;
}

class SpecialRoute {
  final String route;
  final bool requiredSupportedChain;
  final bool requiredConnected;

  final bool? except;

  SpecialRoute(
    this.route, {
    //dùng bool để nó có thể truyền vô requiredSupport, bởi vì nó là final, không thể gán giá trị nhiều lần
    bool requiredSupportedChain = false,
    this.requiredConnected = false,
    this.except,
  }) : requiredSupportedChain = requiredConnected || requiredSupportedChain;
}

abstract class Routes {
  static const splash = RoutePath('/');
  static const login = RoutePath('/login');
  static const main = RoutePath('/main');
  static const unauthenticated = RoutePath('/401');
  static const blogs = RoutePath('/blog');
  static const products = RoutePath('/products');
  static const product_detail = RoutePath('/productDetail');
  static const cart = RoutePath('/cart');
}

final List<GetPage> getPages = [
  GetPage(
    name: Routes.splash.sp,
    page: () => SplashScreen(),
    binding: SplashBinding(),
  ),
  GetPage(
      name: Routes.login.sp,
      page: () => LoginScreen(),
      binding: LoginBinding()),
  GetPage(
    name: Routes.main.sp,
    page: () => HomeScreen(),
  ),
  GetPage(
    name: Routes.blogs.sp,
    page: () => BlogsView(),
    binding: BlogBinding(),
  ),
  GetPage(
    name: Routes.products.sp,
    page: () => ProductsScreen(),
    binding: ProductBinding(),
  ),
  GetPage(
    name: Routes.product_detail.p,
    page: () => ProductDetailScreen(),
    binding: ProductDetailBinding(),
  ),
  GetPage(
    name: Routes.cart.p,
    page: () => CartView(),
  )
].toList();
