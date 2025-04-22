import 'package:ecomercy_app_flutter/configs/styles/themes/themes.dart';
import 'package:ecomercy_app_flutter/views/voucher/voucher_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/Text/primary_text.dart';

class VoucherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoucherLogic>(() => VoucherLogic());
  }
}

class VoucherView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Ẩn bàn phím,
      child: Scaffold(
        appBar: AppBar(
          title: PrimaryText(
            "Voucher Ubuyee",
            fontSize: 18,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios_outlined),
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: GetX<VoucherLogic>(builder: (logic) {
          return Stack(
            children: [
              ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5.0, bottom: 5),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    color: Theme.of(context).colorScheme.surface,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            cursorColor:
                                Theme.of(context).colorScheme.onSurface,
                            style: GoogleFonts.lora(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 14,
                              height: 1.5,
                              // Khoảng cách dòng
                            ),
                            decoration: InputDecoration(
                              labelText: "Nhập mã Ubuyee voucher",
                              labelStyle: GoogleFonts.lora(
                                color: ThemeConfigs.textSecondary(context),
                                fontSize: 14,
                                height: 1.5,
                                // Khoảng cách dòng
                              ),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    width: 2),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý khi nhấn "Áp dụng"
                            print("Đã áp dụng");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.onSurface,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15))),
                            elevation: 0,
                          ),
                          child: PrimaryText(
                            "Áp dụng",
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: logic.state.isLoading.value
                          ? Center(
                        child: Lottie.asset(
                            'assets/animations/load_more.json',
                            width: 150,
                            height: 150),
                      )
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimaryText("Ưu đãi phí vận chuyển"),
                          SizedBox(
                            height: 5,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var voucher = logic.state.vouchers[index];
                                return Obx(() => GestureDetector(
                                  onTap: () {
                                    logic.state.selectedShip
                                        .value = index;
                                    print(logic
                                        .state.selectedShip.value);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.1),
                                          // Màu bóng
                                          spreadRadius: 0.5,
                                          // Độ lan
                                          blurRadius: 1,
                                          // Độ mờ
                                          offset: Offset(
                                              0, 2), // Độ lệch bóng
                                        ),
                                      ],
                                    ),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/vouchership.png",
                                            fit: BoxFit.contain,
                                            width: 100,
                                            height: 100,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                PrimaryText(
                                                  "Tên voucher".toUpperCase(),
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                                PrimaryText(
                                                  "Mô tả của voucher",
                                                  fontSize: 12,
                                                ),
                                                PrimaryText(
                                                  "Ngày hết hạn: ${logic.formatDateTime(voucher.expiryDate.toString())}",
                                                  fontSize: 12,
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: 20, left: 10),
                                            width: 25,
                                            // Đảm bảo kích thước đồng bộ
                                            height: 25,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: logic
                                                  .state
                                                  .selectedShip
                                                  .value ==
                                                  index
                                                  ? Colors.green
                                                  : Colors
                                                  .transparent,
                                              border: Border.all(
                                                  color: logic
                                                      .state
                                                      .selectedShip
                                                      .value ==
                                                      index
                                                      ? Colors.green
                                                      : Theme.of(
                                                      context)
                                                      .colorScheme
                                                      .onSurface,
                                                  width: 2),
                                            ),
                                            child: logic
                                                .state
                                                .selectedShip
                                                .value ==
                                                index
                                                ? Center(
                                                child: Icon(
                                                    Icons.check,
                                                    color: Colors
                                                        .white,
                                                    size: 20))
                                                : null,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )); // Thay bằng widget thực tế bạn cần
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 15),
                              itemCount: 2),
                          Container(
                            height: 70,
                            child: Center(child: PrimaryText("Xem thêm")),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: logic.state.isLoading.value
                          ? Center(
                              child: Lottie.asset(
                                  'assets/animations/load_more.json',
                                  width: 150,
                                  height: 150),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryText("Mã giảm giá"),
                                SizedBox(
                                  height: 5,
                                ),
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var voucher = logic.state.vouchers[index];
                                      return Obx(() => GestureDetector(
                                            onTap: () {
                                              logic.state.selectedVoucher
                                                  .value = index;
                                              print(logic
                                                  .state.selectedVoucher.value);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    // Màu bóng
                                                    spreadRadius: 0.5,
                                                    // Độ lan
                                                    blurRadius: 1,
                                                    // Độ mờ
                                                    offset: Offset(
                                                        0, 2), // Độ lệch bóng
                                                  ),
                                                ],
                                              ),
                                              child: IntrinsicHeight(
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 100, width: 100,
                                                      child: Align(
                                                        alignment: Alignment.center, // hoặc topLeft, topCenter, bottomRight, etc.
                                                        child: Image.asset(
                                                          "assets/voucher.png",
                                                          fit: BoxFit.contain,
                                                          width: 70, // Giữ kích thước nhỏ
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          PrimaryText(
                                                            voucher.name.toUpperCase(),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                          ),
                                                          PrimaryText(
                                                            voucher.description,
                                                            fontSize: 12,
                                                          ),
                                                          PrimaryText(
                                                            "Ngày hết hạn: ${logic.formatDateTime(voucher.expiryDate.toString())}",
                                                            fontSize: 12,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 20, left: 10),
                                                      width: 25,
                                                      // Đảm bảo kích thước đồng bộ
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: logic
                                                                    .state
                                                                    .selectedVoucher
                                                                    .value ==
                                                                index
                                                            ? Colors.green
                                                            : Colors
                                                                .transparent,
                                                        border: Border.all(
                                                            color: logic
                                                                        .state
                                                                        .selectedVoucher
                                                                        .value ==
                                                                    index
                                                                ? Colors.green
                                                                : Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSurface,
                                                            width: 2),
                                                      ),
                                                      child: logic
                                                                  .state
                                                                  .selectedVoucher
                                                                  .value ==
                                                              index
                                                          ? Center(
                                                              child: Icon(
                                                                  Icons.check,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 20))
                                                          : null,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )); // Thay bằng widget thực tế bạn cần
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 15),
                                    itemCount: logic.state.vouchers.length),
                                Container(
                                  height: 70,
                                  child: Center(child: PrimaryText("Hết")),
                                ),
                              ],
                            ),
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      border: Border(
                          top: BorderSide(
                              width: 0.5,
                              color: Theme.of(context).colorScheme.onPrimary))),
                  child: Center(
                    child: SizedBox(
                      width: 375,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            logic.selectThisVoucher();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          child: PrimaryText(
                            "Đồng ý",
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
