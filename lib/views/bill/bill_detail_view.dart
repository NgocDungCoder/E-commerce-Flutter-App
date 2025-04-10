import 'package:ecomercy_app_flutter/configs/styles/themes/themes.dart';
import 'package:ecomercy_app_flutter/views/bill/bill_detail_logic.dart';
import 'package:ecomercy_app_flutter/widgets/Text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../routes/route.dart';

class BillDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: PrimaryText(
            "Chi tiết đơn hàng",
            color: Colors.white,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.offNamed(Routes.products.p);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body: GetX<BillDetailLogic>(builder: (logic) {
          return logic.state.isLoading.value
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface),
                  child: ListView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Color(0xFF66D2CE),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: PrimaryText(
                                    "Đơn hàng đã hoàn thành",
                                    color: Colors.white,
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // Căn trái cho Row
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      PrimaryText(
                                        "Thông tin vận chuyển",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                      PrimaryText(
                                        "Giao hàng nhanh: ${logic.state.orderID.value}",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                          Icons.arrow_forward_ios_outlined))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.local_shipping_outlined),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      PrimaryText(
                                        "Giao hàng thành công",
                                        fontSize: 14,
                                        color: Color(0xFF66D2CE),
                                      ),
                                      PrimaryText("10-10-2025 10:20",
                                          fontSize: 14),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.centerRight, // Căn lề trái
                              child: Container(
                                width: double.infinity,
                                // Điều chỉnh chiều dài của thanh gạch
                                height: 0.3,
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: PrimaryText(
                                    "Địa chỉ giao hàng",
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on_outlined),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      PrimaryText(
                                        logic.state.order['shippingAddress']
                                                ['name'] ??
                                            "",
                                        fontSize: 14,
                                        color: Color(0xFF66D2CE),
                                      ),
                                      PrimaryText(
                                          "${logic.state.order['shippingAddress']['street'] ?? ""}, ${logic.state.order['shippingAddress']['district'] ?? ""}",
                                          fontSize: 14),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.storefront,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  PrimaryText("Danh sách sản phẩm"),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: logic.state.productsDetail.length,
                                  itemBuilder: (context, index) {
                                    var product =
                                        logic.state.productsDetail[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.product_detail.p,
                                            arguments: product['id']);
                                        print(
                                            '=============PRODUCT SCREEN================>${product['id']}');
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                  product['image'],
                                                  width: 110,
                                                  height: 110,
                                                  fit: BoxFit.cover,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: PrimaryText(
                                                              product['name'],
                                                              fontSize: 14,
                                                            )),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            PrimaryText(
                                                              "Phân loại",
                                                              fontSize: 12,
                                                              color: ThemeConfigs
                                                                  .textSecondary(
                                                                      context),
                                                            ),
                                                            PrimaryText("x${ product['quantity']}",
                                                              fontSize: 12,
                                                              color: ThemeConfigs
                                                                  .textSecondary(
                                                                      context),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: PrimaryText(
                                                            product["price"]
                                                                .toString(),
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                              Align(
                                alignment: Alignment.centerRight, // Căn lề trái
                                child: Container(
                                  width: double.infinity,
                                  // Điều chỉnh chiều dài của thanh gạch
                                  height: 0.3,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  Row(
                                    children: [
                                      PrimaryText(
                                        "Thành tiền: ",
                                        fontSize: 14,
                                      ),
                                      PrimaryText(
                                        logic.state.order["totalAmount"]
                                            .toString(),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons
                                              .keyboard_arrow_down_outlined))
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            PrimaryText(
                              "Bạn cần hỗ trợ ?",
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.keyboard_return_outlined),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    PrimaryText("Gửi yêu cầu Trả hàng"),
                                  ],
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Align(
                                alignment: Alignment.centerRight, // Căn lề trái
                                child: Container(
                                  width: 320,
                                  // Điều chỉnh chiều dài của thanh gạch
                                  height: 0.3,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.chat_outlined),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    PrimaryText("Liên hệ cửa hàng"),
                                  ],
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Align(
                                alignment: Alignment.centerRight, // Căn lề trái
                                child: Container(
                                  width: 320,
                                  // Điều chỉnh chiều dài của thanh gạch
                                  height: 0.3,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.question_mark_outlined),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    PrimaryText("Trung tâm hỗ trợ"),
                                  ],
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  PrimaryText(
                                    "Mã đơn hàng",
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Row(
                                    children: [
                                      PrimaryText(
                                        logic.state.orderID.value,
                                        fontSize: 10,
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Container(
                                        height: 30,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              width: 1),
                                        ),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.black,
                                            // Màu chữ của TextButton
                                            padding: EdgeInsets.zero,
                                            // Điều chỉnh padding
                                            minimumSize: Size(0, 0),
                                          ),
                                          onPressed: () =>
                                              logic.copyToClipboard(context),
                                          child: PrimaryText(
                                            "SAO CHÉP",
                                            fontSize: 9,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    PrimaryText(
                                      "Phương thức thanh toán",
                                      fontSize: 11,
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Tài khoản ngân hàng đã liên kết",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight, // Căn lề trái
                                child: Container(
                                  width: double.infinity,
                                  // Điều chỉnh chiều dài của thanh gạch
                                  height: 0.3,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  PrimaryText(
                                    "Thời gian đặt hàng",
                                    fontSize: 11,
                                  ),
                                  Text(
                                    logic.formatDateTime(
                                        logic.state.order['createdAt']),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  PrimaryText(
                                    "Thi gian hoàn thành đơn",
                                    fontSize: 11,
                                  ),
                                  Text(
                                    "12/10/2025 13:16",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerRight, // Căn lề trái
                                child: Container(
                                  width: double.infinity,
                                  // Điều chỉnh chiều dài của thanh gạch
                                  height: 0.3,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      PrimaryText("Rút gọn"),
                                      Icon(
                                        Icons.keyboard_arrow_up_outlined,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ],
                                  ))
                            ],
                          )),
                    ],
                  ),
                );
        }));
  }
}
