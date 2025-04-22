import 'package:ecomercy_app_flutter/configs/styles/themes/themes.dart';
import 'package:ecomercy_app_flutter/views/setting/setting_logic.dart';
import 'package:ecomercy_app_flutter/widgets/Text/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
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
          S.of(context).accountSetting,
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
                S.of(context).account,
                fontSize: 17,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    S.of(context).accountSecurity,
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
            GestureDetector(
              onTap: () => Get.toNamed(Routes.shippingAddress.p),
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryText(
                      S.of(context).address,
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
                    S.of(context).credit,
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
                S.of(context).setting,
                fontSize: 17,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    S.of(context).settingChat,
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
                    S.of(context).settingNoti,
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
                      PrimaryText(S.of(context).darkMode, fontSize: 15,),
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
                    S.of(context).language,
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  IconButton(
                    onPressed: () {
                      logic.toggleLanguage();
                    },
                    icon: Icon(Icons.translate_outlined, size: 25),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              color: Theme.of(context).colorScheme.primary,
              child: PrimaryText(
                S.of(context).support,
                fontSize: 17,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    S.of(context).contactStore,
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
                    S.of(context).termsPolicy,
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
            GestureDetector(
              onTap: (){Get.toNamed(Routes.infor.p);},
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryText(
                      S.of(context).aboutUs,
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
                    S.of(context).deleteAccountRequest,
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
                      onPressed: () {Get.offNamed(Routes.login.p);},
                      child: PrimaryText(
                        S.of(context).logout,
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
