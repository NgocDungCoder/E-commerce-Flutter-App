
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';


// import '../../widgets/common/primary_scaffold.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(
      LoginController(
        //tìm authservice vì trong constructer đã đăng ký nó
        Get.find(),
        //argument là tham số truyền vào từ trang trước
        nextPage: Get.arguments is Routing ? Get.arguments : null,
      ),
    );
  }
}

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    final auth = controller.authController;

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
                      "Đăng nhập",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      maxLength: 50,
                      onChanged: (value) => state.phone.value = value,
                      decoration: InputDecoration(
                        labelText: 'Số điện thoại',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.phone),
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
                      keyboardType: TextInputType.phone,
                    ),
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
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Chưa có tài khoản?',
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 12),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Quên mật khẩu?',
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: controller.login2,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade700,
                        minimumSize: Size(300, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text("ĐĂNG NHẬP",
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 300,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue, Colors.green, Colors.red, Colors.yellow], // Màu gradient
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                          border: Border.all(width: 2, color: Colors.white),
                      ),

                      child: ElevatedButton(
                        onPressed: controller.gmailLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent, // Để nền trong suốt
                          shadowColor: Colors.transparent, // Ẩn đổ bóng
                          minimumSize: Size(300, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          "ĐĂNG NHẬP GOOGLE",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),

                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => auth.canLocalAuth
                          ? ElevatedButton(
                              onPressed: () => controller.login(
                                reason: 'Đăng nhập vân tay',
                                biometricType: BiometricType.fingerprint,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow.shade600,
                                fixedSize: Size(220, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Sử dụng vân tay",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black)),
                                  Icon(
                                    Icons.fingerprint_outlined,
                                    color: Colors.black,
                                    size: 35,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox.shrink(),
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
