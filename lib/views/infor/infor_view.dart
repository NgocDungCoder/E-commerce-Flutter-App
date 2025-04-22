import 'package:ecomercy_app_flutter/widgets/Text/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Infor_logic.dart';

class InfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InfoController()); // Lấy controller

    return Scaffold(
      appBar: AppBar(
        title: PrimaryText(
          "Giới thiệu",
          fontSize: 18,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_outlined),
          color: Colors.white,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo_xoa_nen.png",
              height: 90,
              width: 150,
            ),
            SizedBox(height: 16),
            Obx(() => PrimaryText(
              controller.versionInfo.isNotEmpty
                  ? controller.versionInfo.value
                  : "Đang tải...",
              fontSize: 16,
            )),
          ],
        ),
      ),
    );
  }
}
