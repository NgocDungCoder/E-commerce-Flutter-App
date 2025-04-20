import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import '../configs/enum/load_status.dart';
import '../routes/route.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/custom_toast.dart';

enum SupportState { unknown, supported, unsupported }

const kEnableBiometric = true;

class AuthController extends GetxController {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  //mặc định
  var supportState = SupportState.unknown.obs;
  var canCheckBiometrics = false.obs;
  var checkFaceId = false.obs;
  var verificationId = "".obs;

  //danh sách các loại xác thực  sinh trắc học
  var availableBiometrics = <BiometricType>[].obs;
  RxBool isFingerprintAvailable = false.obs;
  final _isBiometricSupported = RxBool(false);
  final _isLocalAuth = RxBool(false);

  //getter
  //vì nó động Rx nên khi giá trị thay đổi thì mấy biến này tự thay đổi
  bool get isBiometricSupported => _isBiometricSupported.value;

  // kEnableBiometric: Một hằng số (constant) dùng để bật/tắt tính năng xác thực sinh trắc học trong app.
  // isBiometricSupported: Một biến hoặc hàm kiểm tra xem thiết bị có hỗ trợ biometric không.
  bool get canLocalAuth => kEnableBiometric && isBiometricSupported;

  //xem đã đăng nhâp chưa, ktra xem có thể đăng nhập không và giá trị đăng nhập
  bool get isAuth => (canLocalAuth && _isLocalAuth.value) || !canLocalAuth;

  // Rx<int>(0); // Khởi tạo một biến Rx<int> với giá trị ban đầu là 0
  final _loadUserStatus = Rx<LoadStatus>(LoadStatus.initial);

  LoadStatus get loadUserStatus => _loadUserStatus.value;

  //hàm tự chạy khi khởi tạo
  @override
  Future<void> onInit() async {
    super.onInit();
    await init();
  }

  //Hàm khởi tạo tùy chỉnh
  Future<AuthController> init() async {
    try {
      await _checkDeviceSupport();
      print('1: $_isBiometricSupported');
      if (isBiometricSupported) {
        await checkBiometrics();
        print('2: $canCheckBiometrics');
        await getAvailableBiometrics();
        print('3: $availableBiometrics');
        await canFaceId();
      }
    } catch (e) {
      print(e);
    }
    return this;
  }

  Future<void> _checkDeviceSupport() async {
    try {
      _isBiometricSupported.value =
          await _localAuthentication.isDeviceSupported();
      supportState.value = _isBiometricSupported.value
          ? SupportState.supported
          : SupportState.unsupported;
    } catch (e) {
      supportState.value = SupportState.unsupported;
      print(e);
    }
  }

  Future<void> checkBiometrics() async {
    try {
      canCheckBiometrics.value = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics.value = false;
      print(e);
    }
  }

  Future<void> getAvailableBiometrics() async {
    try {
      availableBiometrics.value =
          await _localAuthentication.getAvailableBiometrics();
      print(availableBiometrics);
      isFingerprintAvailable.value =
          availableBiometrics.contains(BiometricType.fingerprint);
    } on PlatformException catch (e) {
      availableBiometrics.value = <BiometricType>[];
      print(e);
    }
  }

  Future<bool> requireLoginAction({bool throwError = true}) async {
    if (!isAuth) {
      await Get.toNamed(Routes.login.p);
      if (!isAuth && throwError) {
        // throw UnauthenticatedException();
        print('Lỗi to requiredLoginAction');
      }
    }
    return isAuth;
  }

  Future<void> canFaceId() async {
    if (canLocalAuth && availableBiometrics.contains(BiometricType.face)) {
      checkFaceId.value = true;
    } else {
      checkFaceId.value = false;
    }
  }

  Future<bool> localAuth({String? reason, BiometricType? biometricType}) async {
    if (canLocalAuth) {
      if (biometricType != null) {
        //hiện thị hộp thoại yêu cầu xác thực, true khi xác thực thành công, false khi thất bại
        final isAuth = await _localAuthentication.authenticate(
          localizedReason:
              reason ?? 'Please complete the biometrics to proceed.',
          options: const AuthenticationOptions(
            biometricOnly: true,
            //Chỉ cho phép xác thực sinh trắc học, ko dùng pin, mật khẩu
            useErrorDialogs: true,
            //Hiển thị hộp thoại lỗi mặc định nếu xác thực thất bại, khong thì tự try cache đẻ xử lý lỗi
            stickyAuth: true,
            //Duy trì phiên xác thực ngay cả khi ứng dụng bị tạm dừng (ví dụ: khi chuyển sang ứng dụng khác hoặc màn hình tắt).
          ),
        );
        _isLocalAuth.value = isAuth;
        return isAuth;
      }
    }
    return false;
  }

  Future<void> logout() async {
    _isLocalAuth.value = false;
    await Get.offAllNamed(Routes.login.p);
  }

  Future<void> loginWithPass() async {
    _isLocalAuth.value = true;
    await Get.offAllNamed(Routes.products.p);
  }

  Future<void> loginWithEmail(String email, String password) async {
    isLoading.value = true;
    User? user = await _authService.signInWithEmail(email, password);
    isLoading.value = false;
    if (user != null) {
      Get.offAllNamed(Routes.products.sp); // Chuyển đến trang chính
      CustomToast.show(
        title: "Thành công",
        message: "Bạn đã đăng nhập thành công !",
        backgroundColor: Colors.green,
        icon: FontAwesomeIcons.circleCheck,
      );
    } else {
      CustomToast.show(
        title: "Cảnh báo",
        message: "Sai tài khoản hay mật khẩu",
        backgroundColor: Colors.orange,
        icon: Icons.warning,
      );
    }
  }

  Future<bool> register(String email, String password) async {
    User? user = await _authService.signUpWithEmail(email, password);
    isLoading.value = false;
    if (user != null) {
      Get.offAllNamed(Routes.login.p);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print("Lỗi khi resetPass: $e");
      return false;
    }
  }

  // Gửi mã OTP đến số điện thoại
  Future<void> sendOTP(String phoneNumber) async {
    try {
      String formattedPhone = formatPhoneNumber(phoneNumber);

      await _auth.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          CustomToast.show(
            title: "Thành công",
            message: "Đăng nhập tự động !",
            backgroundColor: Colors.green,
            icon: FontAwesomeIcons.circleCheck,
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          CustomToast.show(
            title: "Thất bại",
            message: "Nhập sai số điện thoại",
            backgroundColor: Colors.orange,
            icon: Icons.warning,
          );
        },
        codeSent: (String verId, int? resendToken) {
          verificationId.value = verId;
          Get.toNamed("/otp"); // Chuyển sang màn OTP
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
        },
      );
    } catch (e) {
      CustomToast.show(
        title: "Lỗi",
        message: "Gửi OTP thất bại !",
        backgroundColor: Colors.red,
        icon: Icons.error,
      );
      print("Gửi OTP thất bại: ${e.toString()}");
    }
  }

  // Hàm xử lý số điện thoại
  String formatPhoneNumber(String phone) {
    phone = phone.trim();

    // Nếu số điện thoại bắt đầu bằng "0", đổi thành "+84"
    if (phone.startsWith("0")) {
      phone = "+84" + phone.substring(1);
    }

    // Nếu số điện thoại đã có "+84", giữ nguyên
    if (!phone.startsWith("+")) {
      phone = "+84" + phone;
    }
    print("phone format: $phone");

    return phone;
  }

  // Xác thực OTP
  Future<void> verifyOTP(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      CustomToast.show(
        title: "Thành công",
        message: "Bạn đã đăng nhập thành công !",
        backgroundColor: Colors.green,
        icon: FontAwesomeIcons.circleCheck,
      );
      Get.offAllNamed(
          Routes.products.p); // Chuyển hướng sau khi đăng nhập thành công
    } catch (e) {
      CustomToast.show(
        title: "Lỗi",
        message: "Đăng nhập thất bại, vui lòng thử lại!",
        backgroundColor: Colors.red,
        icon: Icons.error,
      );
    }
  }
}
