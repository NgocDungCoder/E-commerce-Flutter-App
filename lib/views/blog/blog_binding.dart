import 'package:ecomercy_app_flutter/views/blog/blog_logic.dart';
import 'package:get/get.dart';

class BlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlogLogic>(() => BlogLogic());
  }

}