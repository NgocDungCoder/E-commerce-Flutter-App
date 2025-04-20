import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ecomercy_app_flutter/views/main/home/home_logic.dart';
import 'package:ecomercy_app_flutter/views/main/notification/nontification_logic.dart';
import 'package:ecomercy_app_flutter/views/main/profile/profile_logic.dart';
import 'package:ecomercy_app_flutter/views/main/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import 'home/home_view.dart';
import 'main_logic.dart';
import 'notification/notification_view.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainLogic>(() => MainLogic());
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => NotiLogic());
    Get.lazyPut(() => ProfileLogic());
  }

}
class MainView extends GetView<MainLogic> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Obx(() => _buildBody()),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.black,
        activeColor: Colors.white,
        height: 60,
        color: Colors.white70,
        curveSize: 60,
        top: -20,
        style: TabStyle.react,
        initialActiveIndex: controller.state.currentIndex.value,
        onTap: controller.changeTab,
        items: [
          TabItem(icon: Icons.home, title: S.of(context).home),
          TabItem(icon: Icons.notifications, title: S.of(context).notification),
          TabItem(icon: Icons.person, title: S.of(context).profile),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (controller.state.currentIndex.value) {
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
