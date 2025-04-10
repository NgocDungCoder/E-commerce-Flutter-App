import 'package:ecomercy_app_flutter/configs/styles/themes/themes.dart';
import 'package:ecomercy_app_flutter/routes/route.dart';
import 'package:ecomercy_app_flutter/views/products/product_logic.dart';
import 'package:ecomercy_app_flutter/widgets/Scaffold/primary_scaffold.dart';
import 'package:ecomercy_app_flutter/widgets/Text/primary_text.dart';
import 'package:ecomercy_app_flutter/widgets/footer/footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: GetX<ProductLogic>(builder: (controller) {
        return controller.state.isInitialLoading.value
            ? Container(
                color: Theme.of(context).colorScheme.surface,
                child: Center(
                  child: Lottie.asset('assets/animations/cat_loading.json',
                      width: 150, height: 150),
                ),
              )
            : RefreshIndicator(
                onRefresh: controller.refreshUser,
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView(
                      controller: controller.scrollX.scrollController,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PrimaryText(
                                "${controller.state.totalProducts} sản phẩm",
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                            IconButton(
                              icon: controller.state.isListView.value
                                  ? Icon(Icons.list_alt_rounded)
                                  : Icon(Icons.grid_view),
                              onPressed: controller.toggleListView,
                              color: Theme.of(context).colorScheme.onSurface,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        controller.scrollX.showLottie.value
                            ? Container(
                                height: 700,
                                width: double.infinity,
                                child: Center(
                                    child: Lottie.asset(
                                  'assets/animations/loading.json',
                                  width: 400,
                                  height: 400,
                                  repeat: true,
                                )),
                              )
                            : controller.state.isListView.value
                                ? GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.state.products.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                            childAspectRatio: 0.58),
                                    itemBuilder: (context, index) {
                                      var product =
                                          controller.state.products[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(Routes.product_detail.p,
                                              arguments: product['id']);
                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                border: Border.all(
                                                    color: ThemeConfigs.border,
                                                    width: 0.5),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius
                                                            .vertical(
                                                            top:
                                                                Radius.circular(
                                                                    15)),
                                                    child: Image.network(
                                                      product['image'],
                                                      height: 230,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          const Icon(Icons
                                                              .image_not_supported),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    child: PrimaryText(
                                                        product['name'] ??
                                                            'Tên sản phẩm',
                                                        maxLines: 2,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary,
                                                        fontSize: 14),
                                                  ),
                                                  const Spacer(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: PrimaryText(
                                                            '${product['price'] ?? 'Giá bán'} đ',
                                                            maxLines: 1,
                                                            color: Colors.pink,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: PrimaryText(
                                                            '${product['sold'] ?? 0} đã bán',
                                                            maxLines: 1,
                                                            color: Theme.of(context)
                                                                .colorScheme
                                                                .onPrimary,
                                                            fontSize: 10),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            // Icon giảm giá ở góc trên phải
                                            if (product['isDiscount'])
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: ThemeConfigs.redText,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(15),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.local_offer,
                                                          color: ThemeConfigs
                                                              .whiteText,
                                                          size: 14),
                                                      const SizedBox(width: 3),
                                                      Text(
                                                        '${product['discount']} %',
                                                        style: const TextStyle(
                                                            color: ThemeConfigs
                                                                .whiteText,
                                                            fontSize: 13),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                : ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.state.products.length,
                                    itemBuilder: (context, index) {
                                      var product =
                                          controller.state.products[index];
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    height: 220,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            Colors.blueAccent,
                                                            Colors.red
                                                          ],
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight),
                                                      border: Border.all(
                                                        width: 3,
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(15),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10)),
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            Routes
                                                                .product_detail
                                                                .p,
                                                            arguments:
                                                                product['id']);
                                                      },
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
                                                          product["image"],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  if (product['isDiscount'])
                                                    Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 8,
                                                                vertical: 4),
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: ThemeConfigs
                                                              .redText,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                                Icons
                                                                    .local_offer,
                                                                color: ThemeConfigs
                                                                    .whiteText,
                                                                size: 14),
                                                            const SizedBox(
                                                                width: 3),
                                                            Text(
                                                              '${product['discount']} %',
                                                              style: const TextStyle(
                                                                  color: ThemeConfigs
                                                                      .whiteText,
                                                                  fontSize: 13),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 220,
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      PrimaryText(
                                                        product["name"],
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 20,
                                                        letterSpacing: 2,
                                                      ),
                                                      PrimaryText(
                                                          'Mô tả sản phẩm'),
                                                      PrimaryText(
                                                        '${product['price'] ?? 'Giá bán'} đ',
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      PrimaryText("⭐ 4.5"),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              PrimaryText(
                                                                  "Size"),
                                                              SizedBox(
                                                                width: 7,
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 30,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Theme.of(context)
                                                                      .colorScheme
                                                                      .primary,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border.all(
                                                                      width: 1,
                                                                      color: Theme.of(context)
                                                                          .colorScheme
                                                                          .onPrimary),
                                                                ),
                                                                child: Center(
                                                                    child:
                                                                        PrimaryText(
                                                                  "S",
                                                                  fontSize: 15,
                                                                )),
                                                              ),
                                                              SizedBox(
                                                                width: 7,
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 30,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Theme.of(context)
                                                                      .colorScheme
                                                                      .primary,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border.all(
                                                                      width: 1,
                                                                      color: Theme.of(context)
                                                                          .colorScheme
                                                                          .onPrimary),
                                                                ),
                                                                child: Center(
                                                                    child:
                                                                        PrimaryText(
                                                                  "M",
                                                                  fontSize: 15,
                                                                )),
                                                              ),
                                                              SizedBox(
                                                                width: 7,
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 30,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Theme.of(context)
                                                                      .colorScheme
                                                                      .primary,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border.all(
                                                                      width: 1,
                                                                      color: Theme.of(context)
                                                                          .colorScheme
                                                                          .onPrimary),
                                                                ),
                                                                child: Center(
                                                                    child:
                                                                        PrimaryText(
                                                                  "L",
                                                                  fontSize: 15,
                                                                )),
                                                              )
                                                            ],
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .favorite_border_outlined,
                                                            color: Colors.red,
                                                            size: 30,
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      );
                                    }),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Nút "<<" về trang đầu tiên
                            IconButton(
                              onPressed: controller.state.currentPage > 1
                                  ? () => controller.onPageSelected(1)
                                  : null,
                              icon: Icon(Icons.first_page),
                            ),
                            ...List.generate(5, (index) {
                              int startPage =
                                  controller.state.currentPage.value -
                                      2; // Xác định trang bắt đầu
                              if (startPage < 1)
                                startPage = 1; // Không nhỏ hơn 1
                              if (startPage + 4 > controller.state.totalPages)
                                startPage = controller.state.totalPages -
                                    4; // Không vượt tổng trang
                              if (startPage < 1)
                                startPage = 1; // Tránh lỗi nếu totalPages < 5

                              int pageNumber = startPage + index;
                              if (pageNumber > controller.state.totalPages)
                                return SizedBox
                                    .shrink(); // Không hiển thị nếu vượt tổng trang

                              bool isSelected =
                                  controller.state.currentPage == pageNumber;

                              return Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.black
                                        : Color(0xFFBCCCDC),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    controller.scrollX.scrollToTop();
                                    controller.onPageSelected(pageNumber);
                                  },
                                  child: Text(
                                    '$pageNumber',
                                    style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                )),
                              );
                            }),
                            IconButton(
                              onPressed: controller.state.currentPage <
                                      controller.state.totalPages
                                  ? () => controller.onPageSelected(
                                      controller.state.totalPages)
                                  : null,
                              icon: Icon(Icons.last_page),
                            ),
                          ],
                        ),
                        Footer(),
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
