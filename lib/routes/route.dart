import 'package:ecomercy_app_flutter/views/bill/bill_detail_binding.dart';
import 'package:ecomercy_app_flutter/views/bill/bill_detail_view.dart';
import 'package:ecomercy_app_flutter/views/blog/blog_binding.dart';
import 'package:ecomercy_app_flutter/views/blog/blog_view.dart';
import 'package:ecomercy_app_flutter/views/cart/cart_view.dart';
import 'package:ecomercy_app_flutter/views/checkout/checkout_binding.dart';
import 'package:ecomercy_app_flutter/views/checkout/checkout_view.dart';
import 'package:ecomercy_app_flutter/views/address/address_list/shiping_address_view.dart';
import 'package:ecomercy_app_flutter/views/info_user/info_user_view.dart';
import 'package:ecomercy_app_flutter/views/login/login_screen.dart';
import 'package:ecomercy_app_flutter/views/login_otp/otp_view.dart';
import 'package:ecomercy_app_flutter/views/notification/notification_view.dart';
import 'package:ecomercy_app_flutter/views/product_detail/product_detail_binding.dart';
import 'package:ecomercy_app_flutter/views/product_detail/product_detail_screen.dart';
import 'package:ecomercy_app_flutter/views/products/products_screen.dart';
import 'package:ecomercy_app_flutter/views/setting/setting_view.dart';
import 'package:ecomercy_app_flutter/views/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../views/address/add_address/add_address_view.dart';
import '../views/address/edit_address/edit_address_view.dart';
import '../views/bill/success_payment_view.dart';
import '../views/forget_password/forget_pass_view.dart';
import '../views/login_otp/login_otp_view.dart';
import '../views/main/home/home_view.dart';
import '../views/main/main_view.dart';
import '../views/register/register_view.dart';
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
  static const register = RoutePath('/register');
  static const main = RoutePath('/main');
  static const home = RoutePath('/home', parent: main);
  static const notification = RoutePath('/notification', parent: main);
  static const profile = RoutePath('/profile', parent: main);
  static const unauthenticated = RoutePath('/401');
  static const blogs = RoutePath('/blog');
  static const products = RoutePath('/products');
  static const product_detail = RoutePath('/productDetail');
  static const cart = RoutePath('/cart');
  static const checkout = RoutePath('/checkout');
  static const shippingAddress = RoutePath('/shipingAddress');
  static const forgotPassword = RoutePath('/forgotPassWord');
  static const loginOTP = RoutePath('/loginOTP');
  static const otp = RoutePath('/otp');
  static const addAddress = RoutePath('/addAddress');
  static const editAddress = RoutePath('/editAddress');
  static const successPayment = RoutePath('/successPayment');
  static const billDetail = RoutePath('/billDetail');
  static const setting = RoutePath('/setting');
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
      transition: Transition.cupertino,
      // Áp dụng hiệu ứng mặc định
      transitionDuration: Duration(milliseconds: 500),
      binding: LoginBinding(),),
  GetPage(
    name: Routes.setting.sp,
    page: () => SettingView(),
    transition: Transition.cupertino,
    // Áp dụng hiệu ứng mặc định
    transitionDuration: Duration(milliseconds: 500),
    binding: SettingBinding(),),
  GetPage(
      name: Routes.successPayment.sp,
      page: () => SuccessPaymentView(),
      transition: Transition.cupertino,
      // Áp dụng hiệu ứng mặc định
      transitionDuration: Duration(milliseconds: 500),
      binding: LoginBinding(),),
  GetPage(
      name: Routes.billDetail.sp,
      page: () => BillDetailView(),
      binding: BillDetailBinding(),
      transition: Transition.cupertino,
      // Áp dụng hiệu ứng mặc định
      transitionDuration: Duration(milliseconds: 500),
      ),
  GetPage(
      name: Routes.loginOTP.sp,
      page: () => LoginOTPView(),
      transition: Transition.cupertino,
      // Áp dụng hiệu ứng mặc định
      transitionDuration: Duration(milliseconds: 500),
      binding: LoginOTPBinding()),
  GetPage(
    name: Routes.forgotPassword.sp,
    page: () => ForgotPasswordView(),
    transition: Transition.cupertino,
    // Áp dụng hiệu ứng mặc định
    transitionDuration: Duration(milliseconds: 500),
    binding: ForgetPassBinding(),
  ),
  GetPage(
    name: Routes.register.sp,
    page: () => RegisterView(),
    binding: RegisterBinding(),
    transition: Transition.cupertino,
    // Áp dụng hiệu ứng mặc định
    transitionDuration: Duration(milliseconds: 500),
  ),
  GetPage(
    name: Routes.addAddress.sp,
    page: () => AddAddressView(),
    binding: AddAddressBinding(),
    transition: Transition.cupertino,
    transitionDuration: Duration(milliseconds: 500),
  ),
  GetPage(
    name: Routes.editAddress.sp,
    page: () => EditAddressView(),
    binding: EditAddressBinding(),
    transition: Transition.cupertino,
    transitionDuration: Duration(milliseconds: 500),
  ),
  GetPage(
    name: Routes.home.sp,
    page: () => HomeView(),
  ),
  GetPage(
    name: Routes.profile.sp,
    page: () => ProfileView(),
  ),
  GetPage(
    name: Routes.notification.sp,
    page: () => NotificationView(),
  ),
  GetPage(
    name: Routes.main.sp,
    page: () => MainView(),
  ),
  GetPage(
    name: Routes.otp.sp,
    page: () => OtpView(),
    binding: OtpBinding(),
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
    name: Routes.product_detail.sp,
    page: () => ProductDetailScreen(),
    binding: ProductDetailBinding(),
  ),
  GetPage(
    name: Routes.cart.sp,
    page: () => CartView(),
  ),
  GetPage(
    name: Routes.checkout.sp,
    page: () => CheckoutView(),
    binding: CheckoutBinding(),
  ),
  GetPage(
    name: Routes.shippingAddress.sp,
    page: () => ShippingAddressView(),
  )
].toList();
