import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomToast {
  static void show({
    required String title,
    required String message,
    Color backgroundColor = Colors.blue,
    IconData icon = Icons.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.closeAllSnackbars(); // Đóng tất cả snackbar trước đó

    Get.rawSnackbar(
      titleText: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      icon: Icon(icon, color: Colors.white),
      backgroundColor: backgroundColor,
      duration: duration,
      borderRadius: 10,
      margin: EdgeInsets.all(16),
      snackPosition: SnackPosition.TOP,
    );
  }
}
