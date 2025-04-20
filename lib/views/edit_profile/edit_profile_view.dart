import 'package:ecomercy_app_flutter/configs/styles/themes/themes.dart';
import 'package:ecomercy_app_flutter/views/edit_profile/edit_profile_logic.dart';
import 'package:ecomercy_app_flutter/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intl/intl.dart';

import '../../generated/l10n.dart';
import '../../routes/route.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileLogic>(() => EditProfileLogic());
  }
}

class EditProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: PrimaryText(
          S.of(context).editProfile,
          color: Colors.white,
          fontSize: 18,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.check,
              size: 30,
            ),
            color: Colors.white,
          )
        ],
      ),
      body: GetX<EditProfileLogic>(builder: (logic) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Theme.of(context).colorScheme.surface,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    logic.pickImage();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    child: Center(
                        child: Stack(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(75),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: Obx(() {
                              final selectedImage = logic.state.selectedImage.value;
                              final avatarUrl = logic.state.avatarUrl.value;

                              print("avatarWidget rebuild - selectedImage: $selectedImage");

                              return ClipRRect(
                                borderRadius: BorderRadius.circular(75),
                                child: selectedImage != null
                                    ? Image.file(selectedImage, fit: BoxFit.cover)
                                    : Image.asset(
                                  avatarUrl.isNotEmpty ? avatarUrl : "assets/product9.png",
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                          ),
                        ),

                        // Lớp mờ dưới
                        Positioned(
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () {
                              // show bottom sheet chọn ảnh
                            },
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color:
                                        Theme.of(context).colorScheme.surface),
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  // Bắt đầu từ trên
                                  end: Alignment.bottomCenter,
                                  // Kết thúc dưới
                                  colors: [
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.8),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 60,
                          right: 0,
                          child: PrimaryText(
                            S.of(context).edit,
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.editFieldProfile.p, arguments: {
                      'title': 'Chỉnh sửa tên',
                      'initialValue': logic.state.name.value,
                      'hintText': 'Nhập tên mới',
                      'isMultiline': false,
                      'onSave': (String value) async {
                        logic.state.name.value = value;
                        print(
                            "đã đổi tên thành công thành: ${logic.state.name.value}");
                      },
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Theme.of(context).colorScheme.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryText(
                          S.of(context).name,
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        Row(
                          children: [
                            PrimaryText(
                                logic.state.name.value.isNotEmpty
                                    ? logic.state.name.value
                                    : S.of(context).setupNow,
                                fontSize: 14,
                                color: ThemeConfigs.textSecondary(context)),
                            Icon(Icons.arrow_forward_ios,
                                size: 15,
                                color: ThemeConfigs.textSecondary(context)),
                          ],
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
                    height: 0.3,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.editFieldProfile.p, arguments: {
                      'title': 'Chỉnh sửa bio',
                      'initialValue': logic.state.bio.value,
                      'hintText': 'Nhập bio mới',
                      'maxLength': 150,
                      'isMultiline': true,
                      'onSave': (String value) async {
                        logic.state.bio.value = value;
                        print(
                            "đã đổi tên thành công thành: ${logic.state.bio.value}");
                      },
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryText(
                          "Bio",
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.72,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: PrimaryText(
                                    logic.state.bio.value.isNotEmpty
                                        ? logic.state.bio.value
                                        : S.of(context).setupNow,
                                    fontSize: 14,
                                    color: ThemeConfigs.textSecondary(context)),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                size: 15,
                                color: ThemeConfigs.textSecondary(context)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center, // Căn lề trái
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    // Điều chỉnh chiều dài của thanh gạch
                    height: 0.3,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    logic.genderController.showGenderDialog(
                      context,
                      onSelected: (gender) {
                        logic.state.gender.value =
                            gender; // cập nhật sau khi chọn xong
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Theme.of(context).colorScheme.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryText(
                          S.of(context).gender,
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        Row(
                          children: [
                            PrimaryText(
                              logic.state.gender.value.isNotEmpty
                                  ? logic.state.gender.value
                                  : S.of(context).setupNow,
                              fontSize: 14,
                              color: ThemeConfigs.textSecondary(context),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                size: 15,
                                color: ThemeConfigs.textSecondary(context)),
                          ],
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
                    height: 0.3,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    logic.pickDate(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Theme.of(context).colorScheme.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryText(
                          S.of(context).birthday,
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        Row(
                          children: [
                            PrimaryText(
                                logic.state.birthDay.value != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(logic.state.birthDay.value!)
                                    : S.of(context).setupNow,
                                fontSize: 14,
                                color: ThemeConfigs.textSecondary(context)),
                            Icon(Icons.arrow_forward_ios,
                                size: 15,
                                color: ThemeConfigs.textSecondary(context)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center, // Căn lề trái
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15),
                    width: double.infinity,
                    // Điều chỉnh chiều dài của thanh gạch
                    height: 0.3,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.editFieldProfile.p, arguments: {
                      'title': 'Chỉnh sửa số điện thoại',
                      'initialValue': logic.state.phone.value,
                      'hintText': 'Nhập số điện thoại mới',
                      'maxLength': 10,
                      'isMultiline': false,
                      'onSave': (String value) async {
                        logic.state.phone.value = value;
                        print(
                            "đã đổi sđt thành công thành: ${logic.state.phone.value}");
                      },
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Theme.of(context).colorScheme.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryText(
                          S.of(context).phoneNumber,
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        Row(
                          children: [
                            PrimaryText(
                              logic.state.phone.value.isNotEmpty
                                  ? logic.state.phone.value
                                  : S.of(context).setupNow,
                              fontSize: 14,
                              color: ThemeConfigs.textSecondary(context),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                size: 15,
                                color: ThemeConfigs.textSecondary(context)),
                          ],
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
                    height: 0.3,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.editFieldProfile.p, arguments: {
                      'title': 'Chỉnh sửa email',
                      'initialValue': logic.state.email.value,
                      'hintText': 'Nhập email mới',
                      'maxLength': 50,
                      'isMultiline': false,
                      'onSave': (String value) async {
                        logic.state.email.value = value;
                        print(
                            "đã đổi email thành công thành: ${logic.state.email.value}");
                      },
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Theme.of(context).colorScheme.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryText(
                          "Email",
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        Row(
                          children: [
                            PrimaryText(
                              logic.state.email.value.isNotEmpty
                                  ? logic.state.email.value
                                  : S.of(context).setupNow,
                              fontSize: 14,
                              color: ThemeConfigs.textSecondary(context),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                size: 15,
                                color: ThemeConfigs.textSecondary(context)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center, // Căn lề trái
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    // Điều chỉnh chiều dài của thanh gạch
                    height: 0.3,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.primary,
                  child: PrimaryText(
                    S.of(context).linkedAccount,
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Align(
                  alignment: Alignment.center, // Căn lề trái
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    // Điều chỉnh chiều dài của thanh gạch
                    height: 0.3,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
