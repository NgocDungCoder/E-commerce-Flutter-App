import 'package:ecomercy_app_flutter/views/checkout/checkout_logic.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../routes/route.dart';
import '../../../widgets/Text/primary_text.dart';


class ShippingAddressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PrimaryText(
          "Chọn địa chỉ giao hàng",
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
      ),
      body: GetX<CheckoutLogic>(builder: (logic) {
        return Stack(children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView(
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
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: logic.state.addresses.length,
                      itemBuilder: (context, index) {
                        var address = logic.state.addresses[index];
                        return GestureDetector(
                          onTap: () {
                            logic.state.selectedAddress.value = index; // Cập nhật chỉ số được chọn
                            print(logic.state.selectedAddress.value);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Obx(
                            () => Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.5, color: Colors.grey))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 24, // Kích thước vòng ngoài
                                        height: 24,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(
                                            color: logic.state.selectedAddress
                                                        .value ==
                                                    index
                                                ? Colors.green
                                                : Colors.grey,
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 13,
                                            // Giảm kích thước vòng trong
                                            height: 13,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: logic.state.selectedAddress
                                                          .value ==
                                                      index
                                                  ? Colors.green
                                                  : Colors
                                                      .transparent, // Vòng trong màu xanh
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                PrimaryText(
                                                  address.name,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                PrimaryText(
                                                  " | ${address.phone}",
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4,),
                                            PrimaryText(address.street,
                                                fontSize: 10),
                                            PrimaryText(address.district,
                                                fontSize: 10),
                                            SizedBox(height: 4,),
                                            address.isSelected ? Container(
                                              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.green, width: 1), // Viền màu xanh
                                                borderRadius: BorderRadius.circular(5.0), // Bo góc cho viền
                                              ),
                                              child: Text(
                                                'Mặc định', // Nội dung chữ
                                                style: TextStyle(
                                                  fontSize: 10, // Kích thước chữ
                                                  fontWeight: FontWeight.w400, // Chữ đậm
                                                  color: Colors.green, // Màu chữ
                                                ),
                                              ),
                                            ) : SizedBox.shrink()

                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  TextButton(
                                      onPressed: () {Get.toNamed(Routes.editAddress.p, arguments: index);},
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero),
                                      child: PrimaryText(
                                        "Sửa",
                                        color: Color(0xFF3E5879),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  SizedBox(height: 69,),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.addAddress.p); // Điều hướng đến màn hình thêm địa chỉ
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                        size: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      PrimaryText(
                        "Thêm địa chỉ mới",
                        color: Colors.white,
                      ),
                    ],
                  )),
            ),
          )
        ]);
      }),
    );
  }
}
