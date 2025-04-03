void printLog(String message) {
  const String green = '\x1B[32m';  // Màu xanh lá
  const String yellow = '\x1B[33m'; // Màu vàng
  const String reset = '\x1B[0m';   // Reset màu về mặc định

  print('$green***************************************');
  print('$yellow LOG START: $message');
  print('$green***************************************');
}
