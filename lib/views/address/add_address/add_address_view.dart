import 'package:ecomercy_app_flutter/views/address/add_address/add_address_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/Text/primary_text.dart';

class AddAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddAddressLogic>(AddAddressLogic());
  }
}

class AddAddressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: PrimaryText(
          "Thêm địa chỉ mới",
          color: Colors.white,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: GetX<AddAddressLogic>(builder: (logic) {
        return Padding(
          padding: EdgeInsets.all(16.0),
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
                  color: Colors.grey,
                  margin: EdgeInsets.only(bottom: 5),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Họ và tên",
                  labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.orange, width: 2),
                  ),
                ),
                onChanged: (value) => logic.state.name.value = value,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
              SizedBox(height: 20),
              TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Số điện thoại",
                  labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.orange, width: 2),
                  ),
                ),
                onChanged: (value) => logic.state.phone.value = value,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Tỉnh/Thành phố",
                  labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
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
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Tên đường, số nhà",
                  labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.orange, width: 2),
                  ),
                ),
                onChanged: (value) => logic.state.street.value = value,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
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
                      Get.snackbar("Lỗi", "Vui lòng điền đầy đủ thông tin",
                          backgroundColor: Colors.red, colorText: Colors.white);
                      return;
                    }
                    logic.addNewAddress();
                  },
                  child: PrimaryText(
                    "Lưu địa chỉ",
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
