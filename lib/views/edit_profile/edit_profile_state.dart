import 'dart:io';
import 'package:get/get.dart';

class EditProfileState {
  var selectedImage = Rxn<File>();
  var name = ''.obs;
  var bio = ''.obs;
  var phone = ''.obs;
  var email = ''.obs;
  var avatarUrl = ''.obs;
  var gender = ''.obs;
  var isLoading = false.obs;
  var user = <String, dynamic>{}.obs;

  Rx<DateTime?> birthDay = Rx<DateTime?>(null);

}