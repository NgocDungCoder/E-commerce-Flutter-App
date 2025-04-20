import 'package:get/get.dart';

class EditFieldState {
  var title = ''.obs;
  var initialValue = ''.obs;
  var hintText = ''.obs;
  var text = "".obs;
  var maxLength = 50.obs;
  var isMultiline = false.obs;
  late Future<void> Function(String) onSave;
}