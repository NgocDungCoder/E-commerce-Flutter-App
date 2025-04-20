import 'package:ecomercy_app_flutter/views/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  // thống quản lý Dependency Injection của GetX
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
//() => SplashController() <=> a = SplashController(); return a;
}

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                // gradient: LinearGradient(
                //   begin: Alignment.bottomLeft,
                //   end: Alignment.topRight,
                //   colors: [
                //     Color(0xFF000957),
                //     Color(0xFFFFEB00),
                //   ],
                // ),
                image: DecorationImage(image: AssetImage('assets/splash_screen.png'), fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            top:  MediaQuery.of(context).size.height / 2 - 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'E-commerce App',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 + 50,
            left: 0,
            right: 0,
            //FutureBuilder là một widget đặc biệt trong Flutter dùng để xử lý dữ liệu
            // bất đồng bộ (Future) và tự động cập nhật giao diện khi dữ liệu sẵn sàng
            child: FutureBuilder<bool>(
              //hàm thực thi bất đồng bộ
              future: Future.value((() async {
                await (100 * 4).milliseconds.delay();
                await controller.startApp();
                return true;
              })()),
              //kết quả trả về
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
