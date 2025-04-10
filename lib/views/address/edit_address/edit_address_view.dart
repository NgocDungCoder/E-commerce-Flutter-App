import 'package:ecomercy_app_flutter/utils/custom_dialog.dart';
import 'package:ecomercy_app_flutter/utils/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/Text/primary_text.dart';
import 'edit_address_logic.dart';

class EditAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAddressLogic>(() => EditAddressLogic());
  }
}

class EditAddressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: PrimaryText("Chỉnh sửa địa chỉ", color: Colors.white,), backgroundColor: Colors.black, leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
        ),
        color: Colors.white,
        onPressed: () {
          Get.back();
        },
      ),),
      body: GetX<EditAddressLogic>(builder: (logic) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: PrimaryText(
                  "Địa chỉ",
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  letterSpacing: 2,
                ),
              ),
              Align(
                alignment: Alignment.center, // Căn lề trái
                child: Container(
                  width: double.infinity,
                  // Điều chỉnh chiều dài của thanh gạch
                  height: 1,
                  color: Theme.of(context).colorScheme.onPrimary,
                  margin: EdgeInsets.only(bottom: 5),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                cursorColor: Theme.of(context).colorScheme.onPrimary,
                decoration: InputDecoration(
                  labelText: "Họ và tên",
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.orange, width: 2),
                  ),
                ),
                onChanged: (value) => logic.state.name.value = value,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: logic.nameController,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimary,
                    decoration: TextDecoration.none),
              ),
              SizedBox(height: 20),
              TextField(
                cursorColor: Theme.of(context).colorScheme.onPrimary,
                decoration: InputDecoration(
                  labelText: "Số điện thoại",
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.orange, width: 2),
                  ),
                ),
                onChanged: (value) => logic.state.phone.value = value,
                controller: logic.phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimary,
                    decoration: TextDecoration.none),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Tỉnh/Thành phố",
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.orange, width: 2),
                  ),
                ),
                menuMaxHeight: 250,
                items: logic.state.provinces
                    .map((city) => DropdownMenuItem(
                          value: city,
                          child: Text(city),
                        ))
                    .toList(),
                onChanged: (value) {
                  logic.state.district.value = value ?? "";
                },
              ),
              SizedBox(height: 20),
              TextField(
                cursorColor: Theme.of(context).colorScheme.onPrimary,
                decoration: InputDecoration(
                  labelText: "Tên đường, số nhà",
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.orange, width: 2),
                  ),
                ),
                onChanged: (value) => logic.state.street.value = value,
                controller: logic.streetController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimary,
                    decoration: TextDecoration.none),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Đặt làm địa chỉ mặc định"),
                  Switch(
                    value: logic.state.isDefaut.value,
                    onChanged: (value) {
                      logic.toggleDefault(value);
                    },
                    activeColor: Colors.orange,
                    inactiveThumbColor: Colors.yellow,
                    // Màu của nút khi tắt

                    inactiveTrackColor: Colors.black12,
                    // Màu của đường khi tắt
                    activeTrackColor: Colors.yellow,
                    // Màu của đường khi bật
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Bo góc nhẹ
                    ),
                  ),
                  onPressed: () {
                    if (logic.state.name.value.isEmpty ||
                        logic.state.phone.value.isEmpty ||
                        logic.state.district.value.isEmpty ||
                        logic.state.street.value.isEmpty) {
                      CustomToast.show(
                          title: "Cảnh báo",
                          message: "Vui lòng nhập đầy đủ thông tin",
                          backgroundColor: Colors.orange,
                          icon: Icons.warning);
                      return;
                    }
                    logic.updateAddress();
                  },
                  child: PrimaryText(
                    "Lưu địa chỉ",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Bo góc nhẹ
                    ),
                    // Đặt kích thước tối thiểu
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => CustomAlertDialog(
                            title: "Xác nhận",
                            message: "Bạn có muốn xóa địa chỉ này không",
                            onConfirm: () {
                              Get.back();
                              logic.removeAddress();
                              Future.delayed(
                                Duration(milliseconds: 1500),
                                () {
                                  CustomToast.show(
                                      title: "Thành công",
                                      message: "Xóa địa chỉ thành công !",
                                      backgroundColor: Colors.green,
                                      duration: Duration(microseconds: 1400),
                                      icon: CupertinoIcons
                                          .check_mark_circled_solid);
                                },
                              );

                              Get.back(); // Quay lại màn hình trước
                            },
                            onCancel: () {
                              Get.back();
                            }));
                  },
                  child: PrimaryText(
                    "Xóa địa chỉ",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
