import 'package:get/get.dart';

class RegisterState {
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var isObscure = true.obs;
  var isMatch = true.obs;
  var isValidEmail = true.obs;
}