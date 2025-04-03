import 'package:ecomercy_app_flutter/utils/custom_toast.dart';
import 'package:ecomercy_app_flutter/views/login_otp/otp_logic.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/route.dart';
import '../../widgets/Text/primary_text.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OtpLogic>(OtpLogic());
  }

}
class OtpView extends GetView<OtpLogic> {
  final AuthController authController = Get.find<AuthController>();

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
                      "Nhập OTP",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),

                    Pinput(
                      length: 6,
                      keyboardType: TextInputType.number,
                      onCompleted: (pin) => authController.verifyOTP(pin),
                      defaultPinTheme: PinTheme(
                        width: 50,
                        height: 60,
                        textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    // Hiển thị thời gian đếm ngược
                    Obx(() => Text(
                      "Gửi lại OTP sau: ${controller.countdown.value} giây",
                      style: TextStyle(fontSize: 18, color: Colors.green),
                    )),
                    SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        onPressed: controller.resendOtp,
                        child: PrimaryText(
                          "Gửi lại OTP",
                          color: Colors.white,
                        )),
                    TextButton(
                        onPressed: () => Get.offNamed(Routes.login.p),
                        child: PrimaryText(
                          "Quay lại",
                          color: Colors.white,
                        ),),
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
