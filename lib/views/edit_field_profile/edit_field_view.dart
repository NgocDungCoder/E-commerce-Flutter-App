import 'package:ecomercy_app_flutter/configs/styles/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/Text/primary_text.dart';
import 'edit_field_logic.dart';

class EditFieldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditFieldLogic>(() => EditFieldLogic());
  }
}

class EditFieldView extends GetView<EditFieldLogic> {
  const EditFieldView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final state = controller.state;

      return Scaffold(
        appBar: AppBar(
          title:
              PrimaryText(state.title.value, color: Colors.white, fontSize: 18),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: const Icon(Icons.check, color: Colors.white),
              onPressed: () async {
                final value = controller.inputController.text.trim();
                if (value.isEmpty || value == controller.state.initialValue) {
                  Get.back();
                  return;
                }
                try {
                  await controller.state
                      .onSave(value); // gọi lại hàm từ trang trước
                  Get.back();
                } catch (e) {
                  print("lỗi khi chỉnh sửa profile: $e");
                }
              },
            )
          ],
          leading: IconButton(
            onPressed: () => Get.back(),
            icon:
                const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                cursorColor: Theme.of(context).colorScheme.onPrimary,
                controller: controller.inputController,
                maxLength: controller.state.maxLength.value,
                onChanged: (val) => controller.state.text.value = val,
                // Giới hạn 100 ký tự
                maxLines: state.isMultiline.value ? 5 : 1,
                decoration: InputDecoration(
                  hintText: state.hintText.value,
                  hintStyle:
                      TextStyle(color: ThemeConfigs.textSecondary(context)),
                  border: InputBorder.none,
                  counterText: '',
                  // Ẩn đếm ký tự
                  suffixIcon: controller.state.text.value.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear_outlined),
                          onPressed: () {
                            controller.clearInput(); // Xoá nội dung
                          },
                        )
                      : null,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: PrimaryText(
                "${controller.state.maxLength.value} characters only",
                fontSize: 12,
                color: ThemeConfigs.textSecondary(context),
              ),
            )
          ],
        ),
      );
    });
  }
}
