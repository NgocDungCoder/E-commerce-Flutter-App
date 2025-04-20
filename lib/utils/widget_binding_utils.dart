import 'dart:async';

import 'package:flutter/widgets.dart';

class WidgetsBindingUtils {
  static Future waitForPostFrame() async {
    final completer = Completer();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      completer.complete();
    });
    await completer.future;
  }
}
