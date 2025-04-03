import 'package:ecomercy_app_flutter/views/login/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';

import '../../configs/enum/load_status.dart';
import '../../controllers/auth_controller.dart';
// import '../../enum/load_status.dart';
import '../../routes/route.dart';


class LoginController extends GetxController {
  final AuthController authController;
  final Routing? nextPage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  LoginController(this.authController, {this.nextPage});
  final state = LoginState();
  final box = GetStorage();

  final loadStatus = Rx(LoadStatus.initial);

  Future login({String? reason, BiometricType? biometricType}) async {
    loadStatus.value = LoadStatus.loading;
    //LOGO xoay
    // LoadingDialog.show(message: 'Loggin in');
    try {
      //Nếu localAuth thành công (trả về true hoặc false) → Các dòng lệnh tiếp tục chạy.
      bool isPass = await authController.localAuth(reason: reason,biometricType: biometricType,);
      if(isPass) {
        loadStatus.value = LoadStatus.success;
        // LoadingDialog.hide();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAllNamed(Routes.products.p);
        });
      } else {
        loadStatus.value = LoadStatus.failure;
      }
    } catch (e) {
      loadStatus.value = LoadStatus.failure;
      // LoadingDialog.hide();
      // toastError('Failed to login: $e', delay: 1000.milliseconds);
    } finally {
      // LoadingDialog.hide();
    }
  }
  void login2() async{
    if(state.password.value == ''){
      box.write('password', state.password.value);
      authController.loginWithPass();
      print('Success Đăng nhập thành công');
    } else {
      Get.snackbar('Error', 'Sai mã pin');
    }
  }
  void loginWithEmail() async{
    authController.loginWithEmail(state.email.value, state.password.value);
  }

  void validateEmail(String value) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+$'; // xxx@xxx
    state.isValidEmail.value = RegExp(pattern).hasMatch(value);
  }

  /* Google Login */
  Future<void> gmailLogin() async {

    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      GoogleSignInAccount user = googleUser;

      print('GoogleSignIn ===> id : ${user.id}');
      print('GoogleSignIn ===> email : ${user.email}');
      print('GoogleSignIn ===> displayName : ${user.displayName}');
      print('GoogleSignIn ===> photoUrl : ${user.photoUrl}');

      // if (!mounted) return;
      // Utils.showProgress(context, prDialog);

      UserCredential userCredential;

      GoogleSignInAuthentication googleSignInAuthentication =
      await user.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      userCredential = await _auth.signInWithCredential(credential);
      assert(await userCredential.user?.getIdToken() != null);
      print("User Name: ${userCredential.user?.displayName}");
      print("User Email ${userCredential.user?.email}");
      print("User photoUrl ${userCredential.user?.photoURL}");
      print("uid ===> ${userCredential.user?.uid}");
      String firebasedid = userCredential.user?.uid ?? "";
      print('firebasedid :===> $firebasedid');

      /* Save PhotoUrl in File */
      // mProfileImg =
      // await Utils.saveImageInStorage(userCredential.user?.photoURL ?? "");
      // printLog('mProfileImg :===> $mProfileImg');

      Get.offAllNamed(Routes.products.sp);
    } on FirebaseAuthException catch (e) {
      print('===>Exp${e.code.toString()}');
      print('===>Exp${e.message.toString()}');
      if (e.code.toString() == "user-not-found") {
      } else if (e.code == 'wrong-password') {
        // Hide Progress Dialog
        // await prDialog.hide();
        // printLog('Wrong password provided.');
        // Utils.showToast(wrongpassword);
      } else {
        // Hide Progress Dialog
        // await prDialog.hide();
      }
    }
  }

  Future onRefresh() async {
    await _loadData();
  }

  // Future loadData() async {
  //   loading(() async {
  //     await _loadData();
  //   });
  // }

  Future _loadData() async {
    await Future.wait([]);
  }
  void toggleObscure() {
    state.isObscure.value = !state.isObscure.value;
  }



}
