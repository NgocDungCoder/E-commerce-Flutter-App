import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../info_user/info_user_view.dart';
import '../notification/notification_view.dart';
import 'home/home_view.dart';
import 'main_logic.dart';

class MainView extends StatelessWidget {
  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: _buildBody(),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.black,
        activeColor: Colors.white,
        height: 60,
        color: Colors.white70,
        curveSize: 60,
        top: -20,
        style: TabStyle.react,
        initialActiveIndex: controller.currentIndex.value,
        onTap: controller.changeTab,
        items: const [
          TabItem(icon: Icons.home, title: 'Trang chủ'),
          TabItem(icon: Icons.notifications, title: 'Thông báo'),
          TabItem(icon: Icons.person, title: 'Cá nhân'),
        ],
      ),
    ));
  }

  Widget _buildBody() {
    switch (controller.currentIndex.value) {
      case 0:
        return HomeView();
      case 1:
        return NotificationView();
      case 2:
        return ProfileView();
      default:
        return SizedBox();
    }
  }
}
