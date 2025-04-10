import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ecomercy_app_flutter/configs/styles/themes/themes.dart';
import 'package:ecomercy_app_flutter/views/setting/setting_logic.dart';
import 'package:ecomercy_app_flutter/widgets/Text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingLogic>(() => SettingLogic());
  }
}

class SettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SettingLogic>();
    return Scaffold(
      appBar: AppBar(
        title: PrimaryText(
          "Thiết lập tài khoản",
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              color: Theme.of(context).colorScheme.primary,
              child: PrimaryText(
                "Tài khoản",
                fontSize: 17,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    "Tài khoản và bảo mật",
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios, size: 15),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center, // Căn lề trái
              child: Container(
                width: double.infinity,
                // Điều chỉnh chiều dài của thanh gạch
                height: 0.1,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    "Địa chỉ",
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center, // Căn lề trái
              child: Container(
                width: double.infinity,
                // Điều chỉnh chiều dài của thanh gạch
                height: 0.1,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    "Tài khoản / Thẻ ngân hàng",
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios, size: 15),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              color: Theme.of(context).colorScheme.primary,
              child: PrimaryText(
                "Cài đặt",
                fontSize: 17,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    "Cài đặt chat",
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios, size: 15),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center, // Căn lề trái
              child: Container(
                width: double.infinity,
                // Điều chỉnh chiều dài của thanh gạch
                height: 0.1,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    "Cài đặt thông báo",
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center, // Căn lề trái
              child: Container(
                width: double.infinity,
                // Điều chỉnh chiều dài của thanh gạch
                height: 0.1,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryText('Chế độ tối', fontSize: 15,),
                      Obx(() => Switch.adaptive(
                        value: logic.state.isDarkMode.value,
                        onChanged: (value) {
                          logic.toggleDarkMode(value);
                        },
                      ))
                    ],
                  )
            ),
            Align(
              alignment: Alignment.center, // Căn lề trái
              child: Container(
                width: double.infinity,
                // Điều chỉnh chiều dài của thanh gạch
                height: 0.1,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    "Ngôn ngữ",
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios, size: 15),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              color: Theme.of(context).colorScheme.primary,
              child: PrimaryText(
                "Hỗ trợ",
                fontSize: 17,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    "Liên hệ cửa hàng",
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios, size: 15),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center, // Căn lề trái
              child: Container(
                width: double.infinity,
                // Điều chỉnh chiều dài của thanh gạch
                height: 0.1,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    "Điều khoản & chính sách",
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios, size: 15),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center, // Căn lề trái
              child: Container(
                width: double.infinity,
                // Điều chỉnh chiều dài của thanh gạch
                height: 0.1,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    "Giới thiệu",
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios, size: 15),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center, // Căn lề trái
              child: Container(
                width: double.infinity,
                // Điều chỉnh chiều dài của thanh gạch
                height: 0.1,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    "Yêu cầu xóa tài khoản",
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios, size: 15),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center, // Căn lề trái
              child: Container(
                width: double.infinity,
                // Điều chỉnh chiều dài của thanh gạch
                height: 0.1,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(width: 1, color: Colors.white),
                          )),
                      onPressed: () {},
                      child: PrimaryText(
                        "Đăng xuất",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: PrimaryText(
                      "Ubuyee v 1.0.0",
                      color: ThemeConfigs.textSecondary(context),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
