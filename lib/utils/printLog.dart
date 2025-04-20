import 'dart:developer' as developer;

enum LogLevel {
  info,    // Thông tin (màu xanh lá)
  warning, // Cảnh báo (màu vàng)
  error,   // Lỗi (màu đỏ)
  debug,   // Debug (màu tím)
}

void printLog(String message, {LogLevel level = LogLevel.info, String tag = 'AppLog'}) {
  // Ánh xạ màu sắc và tiền tố dựa trên LogLevel
  String colorCode;
  String prefix;
  switch (level) {
    case LogLevel.info:
      colorCode = '\x1B[32m'; // Xanh lá
      prefix = '[INFO]';
      break;
    case LogLevel.warning:
      colorCode = '\x1B[33m'; // Vàng
      prefix = '[WARNING]';
      break;
    case LogLevel.error:
      colorCode = '\x1B[31m'; // Đỏ
      prefix = '[ERROR]';
      break;
    case LogLevel.debug:
      colorCode = '\x1B[35m'; // Tím
      prefix = '[DEBUG]';
      break;
  }

  // Định dạng log với thời gian, tag và màu sắc
  final timestamp = DateTime.now().toString();
  final formattedMessage = '$colorCode$prefix [$timestamp] $tag: $message\x1B[0m';
  developer.log(formattedMessage, name: tag);
}