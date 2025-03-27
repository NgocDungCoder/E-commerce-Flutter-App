import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import '../configs/enum/load_status.dart';
import '../routes/route.dart';

enum SupportState { unknown, supported, unsupported }

const kEnableBiometric = true;

class AuthController extends GetxController {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  //mặc định
  var supportState = SupportState.unknown.obs;
  var canCheckBiometrics = false.obs;
  var checkFaceId = false.obs;
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
      isFingerprintAvailable.value = availableBiometrics.contains(BiometricType.fingerprint);
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
            biometricOnly: true, //Chỉ cho phép xác thực sinh trắc học, ko dùng pin, mật khẩu
            useErrorDialogs: true, //Hiển thị hộp thoại lỗi mặc định nếu xác thực thất bại, khong thì tự try cache đẻ xử lý lỗi
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
}
