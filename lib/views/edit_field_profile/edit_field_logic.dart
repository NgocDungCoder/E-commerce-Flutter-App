import 'package:ecomercy_app_flutter/views/edit_field_profile/edit_field_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditFieldLogic extends GetxController {
  late final args;
  final state = EditFieldState();
  final inputController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;

    state.title.value = args['title'];
    state.initialValue.value = args['initialValue'];
    inputController.text = state.text.value = state.initialValue.value;
    state.hintText.value = args['hintText'];
    state.maxLength.value = args['maxLength'] ?? 50;
    state.isMultiline.value = args['isMultiline'] ?? false;
    state.onSave = args['onSave'] as Future<void> Function(String);
  }

  void clearInput() {
    inputController.clear();
    state.text.value = '';
  }

}
