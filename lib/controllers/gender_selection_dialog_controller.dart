import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/Text/primary_text.dart';

class GenderSelectionDialogController extends GetxController {
  RxString selectedGender = ''.obs;

  void showGenderDialog(BuildContext context, {required void Function(String) onSelected}) {
    Get.defaultDialog(
      title: "Giới tính",
      titleStyle: GoogleFonts.lora(
        color: Theme.of(context).colorScheme.onPrimary, // sửa màu tùy theme
        fontSize: 18,
        height: 1.5,
      ),
      content: Column(
        children: [
          _genderOption(context, "Male", onSelected),
          _genderOption(context, "Female", onSelected),
          _genderOption(context, "Other", onSelected),
        ],
      ),
    );
  }

  Widget _genderOption(BuildContext context, String gender, void Function(String) onSelected) {
    return ListTile(
      title: PrimaryText(gender),
      onTap: () {
        selectedGender.value = gender;
        onSelected(gender); // gọi callback
        Get.back();
      },
    );
  }

}
