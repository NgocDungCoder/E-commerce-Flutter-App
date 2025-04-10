import 'package:ecomercy_app_flutter/configs/styles/themes/themes.dart';
import 'package:ecomercy_app_flutter/views/cart/cart_logic.dart';
import 'package:ecomercy_app_flutter/widgets/Text/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../routes/route.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.close,
                size: 35,
                color: Colors.white,
              )),
          backgroundColor: Colors.black,
        ),
        body: GetX<CartLogic>(builder: (logic) {
          return logic.state.isIndicatorLoding.value
              ? Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Center(
                    child: Lottie.asset('assets/animations/cat_loading.json',
                        width: 150, height: 150),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: logic.refreshCart,
                  child: Stack(
                    children: [
                      Container(
                        color: Theme.of(context).colorScheme.surface,
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 13.0),
                              child: PrimaryText(
                                'CART',
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 5.0,
                              ),
                            ),
                            logic.state.isLoading.value
                                ? Container(
                                    height: 600,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    child: Center(
                                      child: Lottie.asset(
                                          'assets/animations/load_more.json',
                                          width: 150,
                                          height: 150),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        logic.state.productsDetail.length,
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
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            height: 220,
                                            child: Row(
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                              colors: [
                                                                Colors.red,
                                                                Colors.blue
                                                              ],
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomRight),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                          border: Border.all(
                                                            width: 2,
                                                            color: Colors
                                                                .transparent,
                                                          )),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        15),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10)),
                                                        child: Image.network(
                                                          product['image'] ??
                                                              "https://drive.usercontent.google.com/download?id=1o_9pf1LhTZ1luk3Pcq6u2FJe66X5rsg8&export=view&authuser=0",
                                                          fit: BoxFit.cover,
                                                          width: 150,
                                                          height: 220,
                                                        ),
                                                      ),
                                                    ),
                                                    product['isDiscount']
                                                        ? Positioned(
                                                            top: 0,
                                                            right: 0,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          4),
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color:
                                                                    ThemeConfigs
                                                                        .redText,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          15),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  const Icon(
                                                                      Icons
                                                                          .local_offer,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 14),
                                                                  const SizedBox(
                                                                      width: 3),
                                                                  Text(
                                                                    product['discount']
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color: ThemeConfigs
                                                                            .whiteText,
                                                                        fontSize:
                                                                            13),
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 12),
                                                          child: PrimaryText(
                                                            product['name']
                                                                    .toUpperCase() ??
                                                                "Tên sản phẩm",
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 12),
                                                          child: PrimaryText(
                                                            product['abc'] ??
                                                                'Mô tả sản phẩm',
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 12),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: 30,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onSurface)),
                                                                child:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () =>
                                                                                {
                                                                                  logic.updateQuantityItem(product['cardID'], product['quantity'] - 1),
                                                                                },
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .onSurface,
                                                                        ),
                                                                        padding:
                                                                            EdgeInsets
                                                                                .zero,
                                                                        constraints:
                                                                            BoxConstraints()),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              PrimaryText(
                                                                product['quantity']
                                                                    .toString(),
                                                                fontSize: 17,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Container(
                                                                  width: 30,
                                                                  height: 30,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .onSurface)),
                                                                  child:
                                                                      IconButton(
                                                                    onPressed: () => logic.updateQuantityItem(
                                                                        product[
                                                                            'cardID'],
                                                                        product['quantity'] +
                                                                            1),
                                                                    icon: Icon(
                                                                      Icons.add,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .onSurface,
                                                                    ),
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    constraints:
                                                                        BoxConstraints(),
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 12),
                                                          child: PrimaryText(
                                                            '${product['price'].toString()} đ',
                                                            color: Colors.pink,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ));
                                    }),
                            SizedBox(
                              height: 180,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 180,
                          width: double.infinity,
                          color: Theme.of(context).colorScheme.primary,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center, // Căn lề trái
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Container(
                                    width: double.infinity,
                                    // Điều chỉnh chiều dài của thanh gạch
                                    height: 1,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    PrimaryText(
                                      'Tổng mặt hàng: ',
                                      fontSize: 17,
                                    ),
                                    PrimaryText(
                                      logic.state.itemCount.toString(),
                                      fontSize: 17,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    PrimaryText(
                                      'TỔNG TIỀN:',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 4,
                                    ),
                                    PrimaryText(
                                      '${logic.state.subTotal.toString()} đ',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.pink,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      // Bo góc
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.toNamed(Routes.checkout.p);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.shopping_bag_outlined,
                                        color: ThemeConfigs.whiteText,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      PrimaryText(
                                        'BUY NOW',
                                        color: ThemeConfigs.whiteText,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
        }));
  }
}
