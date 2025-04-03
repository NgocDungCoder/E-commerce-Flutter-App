import 'package:ecomercy_app_flutter/views/register/register_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

// import '../../widgets/common/primary_scaffold.dart';
import '../../routes/route.dart';
import '../login/login_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RegisterLogic>(
      RegisterLogic(
        //tìm authservice vì trong constructer đã đăng ký nó
        Get.find(),
        //argument là tham số truyền vào từ trang trước
        nextPage: Get.arguments is Routing ? Get.arguments : null,
      ),
    );
  }
}

class RegisterView extends GetView<RegisterLogic> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = controller.state;

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
                      "Đăng ký",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      maxLength: 50,
                      onChanged: (value) {
                        state.email.value = value;
                        controller.validateEmail(value);
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.mail_outline),
                        prefixIconColor: Colors.white,
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
                        counterStyle: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9@._-]')),
                        // Chỉ cho phép email hợp lệ
                      ],
                    ),
                    Obx(() => controller.state.isValidEmail.value
                        ? SizedBox()
                        : Text("Email không hợp lệ", style: TextStyle(color: Colors.red))),
                    SizedBox(height: 30),
                    Obx(
                      () => TextField(
                        maxLength: 50,
                        onChanged: (value) => state.password.value = value,
                        obscureText: state.isObscure.value,
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: state.isObscure.value
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_outlined),
                            onPressed: controller.toggleObscure,
                          ),
                          prefixIconColor: Colors.white,
                          suffixIconColor: Colors.white,
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
                          counterStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => TextField(
                        maxLength: 50,
                        onChanged: (value) {
                          state.confirmPassword.value = value;
                          controller.checkMatch();
                        },
                        obscureText: state.isObscure.value,
                        decoration: InputDecoration(
                          labelText: 'Xác nhận mật khẩu',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: state.isObscure.value
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_outlined),
                            onPressed: controller.toggleObscure,
                          ),
                          prefixIconColor: Colors.white,
                          suffixIconColor: Colors.white,
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
                          counterStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    Obx(() => controller.state.isMatch.value
                        ? SizedBox.shrink()
                        : Text("Mật khẩu không trùng khớp",
                            style: TextStyle(color: Colors.red))),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.offNamed(Routes.login.p);
                          },
                          child: Text(
                            'Đã có tài khoản?',
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: controller.register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade700,
                        minimumSize: Size(300, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text("ĐĂNG KÝ",
                          style: TextStyle(fontSize: 20, color: Colors.black)),
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
