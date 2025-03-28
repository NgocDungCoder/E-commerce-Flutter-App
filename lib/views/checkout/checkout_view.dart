import 'package:ecomercy_app_flutter/views/checkout/checkout_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/styles/theme.dart';
import '../../routes/route.dart';
import '../../widgets/Text/primary_text.dart';

class CheckoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PrimaryText(
          "Thanh toán",
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
      body: GetX<CheckoutLogic>(
        builder: (logic) {
          return Stack(
            children: [
              ListView(
                padding: EdgeInsets.all(10),
                children: [
                  Center(
                      child: PrimaryText(
                    'THANH TOÁN',
                    fontWeight: FontWeight.w300,
                    fontSize: 23,
                    letterSpacing: 2,
                  )),
                  Align(
                    alignment: Alignment.center, // Căn lề trái
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        width: 190,
                        // Điều chỉnh chiều dài của thanh gạch
                        height: 1,
                        color: Colors.grey,
                        margin: EdgeInsets.only(bottom: 15),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: PrimaryText(
                        "Địa chỉ giao hàng".toUpperCase(),
                        fontSize: 16,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      )),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.product_detail.p);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PrimaryText(
                                "Nguyễn Văn A",
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                              PrimaryText(
                                "Địa chị nhà",
                                fontWeight: FontWeight.w300,
                                color: Color(0xFF3E5879),
                              ),
                              PrimaryText("01234567889",
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFF3E5879)),
                            ],
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center, // Căn lề trái
                    child: Container(
                      width: double.infinity,
                      // Điều chỉnh chiều dài của thanh gạch
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: logic.cartLogic.state.productsDetail.length,
                      itemBuilder: (context, index) {
                        var product =
                            logic.cartLogic.state.productsDetail[index];
                        return Container(
                          height: 170,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 170,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [Colors.red, Colors.blue],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.transparent,
                                        )),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(10)),
                                      child: Image.network(
                                        product['image'] ??
                                            "https://drive.usercontent.google.com/download?id=1o_9pf1LhTZ1luk3Pcq6u2FJe66X5rsg8&export=view&authuser=0",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  product['isDiscount']
                                      ? Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: const BoxDecoration(
                                              color: ThemeConfigs.redText,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.local_offer,
                                                    color:
                                                        ThemeConfigs.whiteText,
                                                    size: 14),
                                                const SizedBox(width: 3),
                                                Text(
                                                  product['discount']
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: ThemeConfigs
                                                          .whiteText,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink()
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: PrimaryText(
                                          product['name'].toUpperCase() ??
                                              "Tên sản phẩm",
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: PrimaryText(
                                          product['abc'] ?? 'Mô tả sản phẩm',
                                          fontSize: 15,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            PrimaryText(
                                              '${product['price'].toString()} đ',
                                              color: ThemeConfigs.redText,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            PrimaryText(
                                              "x${product['quantity'].toString()}",
                                              fontSize: 17,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center, // Căn lề trái
                    child: Container(
                      width: double.infinity,
                      // Điều chỉnh chiều dài của thanh gạch
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryText(
                          "Tổng số tiền (${logic.cartLogic.state.itemCount.toString()} sản phẩm): ",
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                        PrimaryText(
                          "đ${logic.cartLogic.state.subTotal.value}",
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center, // Căn lề trái
                    child: Container(
                      width: double.infinity,
                      // Điều chỉnh chiều dài của thanh gạch
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Icon(
                            Icons.airplane_ticket_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          PrimaryText(
                            "Thêm mã giảm giá",
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center, // Căn lề trái
                    child: Container(
                      width: double.infinity,
                      // Điều chỉnh chiều dài của thanh gạch
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Icon(
                            Icons.delivery_dining_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                PrimaryText(
                                  "Vận chuyển",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                                Spacer(),
                                PrimaryText(
                                  "Free",
                                  color: Color(0xFF3E5879),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center, // Căn lề trái
                    child: Container(
                      width: double.infinity,
                      // Điều chỉnh chiều dài của thanh gạch
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: PrimaryText(
                      "Phương thức thanh toán".toUpperCase(),
                      fontSize: 16,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  Column(
                    children: List.generate(logic.state.paymentMethods.length,
                        (index) {
                      int value = index + 1;
                      return GestureDetector(
                        onTap: () {
                          logic.state.selectedValue.value =
                              value; // Cập nhật nút được chọn
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        logic.state.iconPaymentMethods[index],
                                        size: 30,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        logic.state.paymentMethods[index],
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 25, // Đảm bảo kích thước đồng bộ
                                    height: 25,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: logic.state.selectedValue == value
                                          ? Colors.green
                                          : Colors.transparent,
                                      border: logic.state.selectedValue == value
                                          ? null // Xóa border khi được chọn
                                          : Border.all(
                                              color: Colors.grey, width: 2),
                                    ),
                                    child: logic.state.selectedValue == value
                                        ? Center(
                                            child: Icon(Icons.check,
                                                color: Colors.white,
                                                size:
                                                    20)) // Cỡ icon phù hợp với container
                                        : null,
                                  )
                                ],
                              ),
                            ),
                            index < 2
                                ? Align(
                                    alignment:
                                        Alignment.centerRight, // Căn lề trái
                                    child: Container(
                                      width: 340,
                                      // Điều chỉnh chiều dài của thanh gạch
                                      height: 0.3,
                                      color: Colors.grey,
                                    ),
                                  )
                                : Align(
                                    alignment:
                                        Alignment.centerRight, // Căn lề trái
                                    child: Container(
                                      width: double.infinity,
                                      // Điều chỉnh chiều dài của thanh gạch
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  )
                          ],
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: PrimaryText(
                      "Chi tiết thanh toán".toUpperCase(),
                      fontSize: 16,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryText(
                        "Tổng tền hàng",
                        fontSize: 14,
                      ),
                      PrimaryText(
                        "đ${logic.cartLogic.state.subTotal}",
                        fontSize: 14,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryText(
                        "Tổng tền phí vận chuyển",
                        fontSize: 14,
                      ),
                      PrimaryText(
                        "đxxxxxx",
                        fontSize: 14,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryText(
                        "Giảm giá phí vận chuyển",
                        fontSize: 14,
                      ),
                      PrimaryText(
                        "đxxxxxx",
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight, // Căn lề trái
                    child: Container(
                      width: double.infinity,
                      // Điều chỉnh chiều dài của thanh gạch
                      height: 0.2,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(vertical: 7),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryText(
                        "Tổng thanh toán",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      PrimaryText(
                        "đ${logic.cartLogic.state.subTotal}",
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text.rich(
                      TextSpan(
                        text:
                            'Nhấn "Đặt hàng" đồng nghĩa với việc bạn đồng ý tuân theo ',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: 'Điều khoản',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 65,
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 65,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              PrimaryText(
                                "Tổng cộng",
                                fontSize: 12,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              PrimaryText(
                                "đ${logic.cartLogic.state.subTotal}",
                                fontSize: 15,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              PrimaryText(
                                "Tiết kiệm",
                                fontSize: 12,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              PrimaryText(
                                "đ00000",
                                fontSize: 12,
                                color: Colors.green,
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 18),
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                // Bo góc
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Get.toNamed(Routes.checkout.p);
                            },
                            child: PrimaryText(
                              'Đặt hàng',
                              color: ThemeConfigs.whiteText,
                              fontSize: 15,
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
