import 'package:ecomercy_app_flutter/views/login_otp/login_otp_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../routes/route.dart';
import '../../utils/custom_toast.dart';
import '../../widgets/Text/primary_text.dart';

class LoginOTPBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginOTPLogic>(LoginOTPLogic());
  }
}

class LoginOTPView extends GetView<LoginOTPLogic> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus
              ?.unfocus(); // Ẩn bàn phím khi nhấn ra ngoài
        },
        child: Stack(
          children: [
            // Nền trắng
            Positioned.fill(
              child: Container(
                color: Colors.black,
              ),
            ),
            Positioned(
              top: -150, // Dịch xuống để tạo hiệu ứng
              left: -300,
              right: 0,
              child: Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.yellow.shade600,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Nền hồng cong phía dưới
            Positioned(
              bottom: -300, // Dịch xuống để tạo hiệu ứng
              left: 0,
              right: -250,
              child: Container(
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.yellow.shade600,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Nội dung chính
            Positioned(
              bottom: -175, // Dịch xuống để tạo hiệu ứng
              left: -150,
              right: 0,
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.yellow.shade400,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Nội dung chính
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Đăng nhập bằng OTP",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      maxLength: 50,
                      controller: phoneController,
                      onChanged: (value) {
                        // state.email.value = value;
                        // controller.validateEmail(value);
                      },
                      decoration: InputDecoration(
                        labelText: "Số điện thoại",
                        prefixText: "+84 ",
                        // Việt Nam (+84)
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.phone),
                        counterStyle: TextStyle(color: Colors.white),
                        prefixIconColor: Colors.white,
                        prefixStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Colors.yellow, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Colors.yellow.shade600, width: 3),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9@._-]')),
                        // Chỉ cho phép email hợp lệ
                      ],
                    ),
                    // Obx(() => controller.state.isValidEmail.value
                    //     ? SizedBox()
                    //     : Text("Email không hợp lệ", style: TextStyle(color: Colors.red))),

                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (phoneController.text.isNotEmpty) {
                          controller.loginOTP(phoneController.text.trim());
                          controller.isLoading.value = true;
                          print(
                              "-----------------------------------${controller.isLoading}");
                        } else {
                          CustomToast.show(
                            title: "Lỗi",
                            message: "Vui lòng nhập số điện thoại hợp lệ",
                            backgroundColor: Colors.red,
                            icon: Icons.error,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade700,
                        minimumSize: Size(140, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Obx(
                        () => controller.isLoading.value
                            ? CircularProgressIndicator(color: Colors.black,)
                            : Text("Gửi OTP",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offNamed(Routes.login.p);
                      },
                      child: PrimaryText(
                        "Quay lại",
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
