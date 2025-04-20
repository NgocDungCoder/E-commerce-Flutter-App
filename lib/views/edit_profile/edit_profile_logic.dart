import 'dart:async';
import 'dart:io';
import 'package:ecomercy_app_flutter/services/user_service.dart';
import 'package:ecomercy_app_flutter/views/edit_profile/edit_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/gender_selection_dialog_controller.dart';
import '../../models/user_model.dart';
import '../../services/photo_service.dart';

class EditProfileLogic extends GetxController {
  final String userId = 'zYhe1dcYsDcr4qGcwKWg';
  final state = EditProfileState();
  final _userService = Get.find<UserService>();
  late UserModel userModel;
  final photoService = Get.find<PhotoService>();
  final GenderSelectionDialogController genderController = Get.put(GenderSelectionDialogController());

  @override
  void onInit() async {
    super.onInit();
    await fetchUserById(userId);
    initUser(userModel);
  }

  Future<void> fetchUserById(String userId) async {
    if (state.isLoading.value) return;
    state.isLoading.value = true;

    try {
      var newUser = await _userService.getUserById(userId);
      if (newUser != null) {
        // final imageProvider = NetworkImage(newUser['image']);
        // final completer = Completer<void>();
        //
        // imageProvider.resolve(ImageConfiguration()).addListener(
        //   ImageStreamListener(
        //         (imageInfo, _) => completer.complete(),
        //     onError: (error, stackTrace) {
        //       print(
        //           "⚠️ Lỗi tải ảnh: $error"); // In lỗi nếu ảnh tải thất bại
        //       completer.complete();
        //     },
        //   ),
        // );
        // state.user.assignAll(newUser);
        userModel = UserModel.fromMap(newUser);

      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu: $e');
    } finally {
      state.isLoading.value = false;
    }
  }

  void pickImage() async {
    await photoService.pickImageFromGallery();
    state.selectedImage.value = photoService.selectedImage.value;
    //Lỗi gán lại Rx thay vì thay đổi giá trị của Rx bằng .value, khiến Obx không nhận được sự thay đổi và không rebuild UI.
    //state.selectedImage = photoService.selectedImage;
  }

  void initUser(UserModel user) {
    state.name.value = user.name;
    state.bio.value = user.bio;
    state.email.value = user.email;
    state.avatarUrl.value = user.avatarUrl;
    state.gender.value = user.gender;
    state.birthDay.value = user.birthday;
    state.phone.value = user.phone;
  }

  Future<void> saveAll() async {
    final updatedUser = UserModel(
      id: 'user_001', // giữ nguyên ID
      name: state.name.value,
      bio: state.bio.value,
      email: state.email.value,
      avatarUrl: state.avatarUrl.value,
      gender: state.gender.value,
      birthday: state.birthDay.value,
      phone: state.phone.value,
    );

    print('📝 Đã lưu user: ${updatedUser.toMap()}');
    Get.snackbar('Thành công', 'Thông tin đã được lưu tạm');
  }


  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: state.birthDay.value ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) state.birthDay.value = picked;
  }

  Image avatarWidget() {
    // Nếu người dùng chọn ảnh mới từ thư viện hoặc máy ảnh
    if (state.selectedImage.value != null) {

      return Image.file(
        state.selectedImage.value!,  // Dùng ảnh người dùng chọn
        fit: BoxFit.cover,
      );
    }

    // Nếu không có ảnh người dùng chọn, dùng avatar cũ hoặc ảnh mặc định
    String avatarUrl = state.avatarUrl.value;
    String defaultAvatar = "assets/product9.png";  // Ảnh mặc định khi không có avatar

    return Image.asset(
      avatarUrl.isNotEmpty ? avatarUrl : defaultAvatar,  // Nếu avatarUrl trống thì dùng ảnh mặc định
      fit: BoxFit.cover,
    );
  }

}

