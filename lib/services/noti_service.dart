import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  //INITIALIZE
  Future<void> initNotification() async {
    if (_isInitialized) return;
    _isInitialized = true;
    
    const initSettingAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: initSettingAndroid,
      iOS: initSettingsIOS,
    );

    await notificationsPlugin.initialize(initSettings);
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'ngocdung_id', // ID kênh thông báo
        'NgocDung noti', // Tên kênh thông báo
        channelDescription: 'Thông báo bình thường', // Mô tả kênh
        importance: Importance.high, // Mức độ quan trọng của thông báo
        priority: Priority.high, // Mức độ ưu tiên
        enableLights: true,
        ledColor: Color(0xFF00FF00),  // Màu sắc ánh sáng
        ledOnMs: 1000,  // Thời gian bật đèn
        ledOffMs: 500,  // Thời gian tắt đèn
      ),
      iOS: DarwinNotificationDetails(), // Cấu hình iOS
    );
  }


  // Hiển thị thông báo
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {

    // Kiểm tra nếu chưa khởi tạo thì không gửi thông báo
    if (!_isInitialized) {
      await initNotification();
    }

    // Gửi thông báo với thông tin đã cấu hình
    return notificationsPlugin.show(id, title, body, notificationDetails());
  }
}
