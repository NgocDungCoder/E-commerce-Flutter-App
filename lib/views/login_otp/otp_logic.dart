import 'dart:async';
import 'package:get/get.dart';

class OtpLogic extends GetxController {
  var countdown = 60.obs; // 60 giây đếm ngược
  Timer? _timer;
  var canResendOtp = false.obs;

  @override
  void onInit() {
    startCountdown();
    super.onInit();
  }

  void startCountdown() {
    canResendOtp.value = false;
    countdown.value = 120;
    _timer?.cancel(); // Hủy timer cũ nếu có

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        canResendOtp.value = true; // Cho phép gửi lại OTP
        _timer?.cancel();
      }
    });
  }

  void resendOtp() {
    if (!canResendOtp.value) return;

    startCountdown(); // Reset lại bộ đếm
    print("OTP đã được gửi lại!");
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
