import 'package:ecomercy_app_flutter/configs/styles/themes/themes.dart';
import 'package:ecomercy_app_flutter/widgets/Text/primary_text.dart';
import 'package:ecomercy_app_flutter/widgets/Scaffold/primary_scaffold.dart';
import 'package:ecomercy_app_flutter/widgets/footer/footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../generated/l10n.dart';
import '../../routes/route.dart';
import '../../widgets/also_like/also_like_section.dart';
import 'product_detail_logic.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: GetX<ProductDetailLogic>(
        builder: (logic) {
          return logic.state.isInitialLoading.value
              ? Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                )
              : Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: ClipRect(
                          child: Image.network(logic.state.product['image'] ??
                              'https://cdn2.tgdd.vn/hoi-dap/969051/huong-dan-cach-chup-anh-co-hien-thi-ngay-gio-bang-01.jpg'),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: PrimaryText(
                            logic.state.product['name'] ?? "Tên sản phẩm",
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: PrimaryText(
                            logic.state.product['detail'] ??
                                "Chi tiết sản phẩm",
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: PrimaryText(
                          "${S.of(context).price}: ${logic.state.product['price'] ?? 'N/A'} VND",
                          fontSize: 18,
                          color: Colors.pink,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: PrimaryText(
                          "${logic.state.product['sold'] ?? 0} ${S.of(context).sold}",
                          fontSize: 16,
                          color: ThemeConfigs.textSecondary(context),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 60,
                        // Độ cao của button
                        width: double.infinity,
                        // Chiều rộng full màn hình
                        color: Colors.black,
                        // Màu nền đen
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        // Khoảng cách lề
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.add, color: Colors.white, size: 30),
                                // Icon dấu +
                                SizedBox(width: 8),
                                // Khoảng cách giữa icon và text
                                TextButton(
                                    onPressed: () {
                                      logic.addToCart('zYhe1dcYsDcr4qGcwKWg',
                                          logic.state.product['id'], 1);
                                      // logic.addToStorage(logic.state.product['id']);
                                    },
                                    child: Text(
                                      S.of(context).addToCart.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing:
                                            1.5, // Tăng khoảng cách chữ
                                      ),
                                    )),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.favorite_border,
                                  color: Colors.white, size: 30),
                              onPressed: () {
                                print('add to favorite');
                                logic.getListProductFromStorage();
                              },
                            ), // Icon trái tim
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryText(
                              S.of(context).material.toUpperCase(),
                              fontSize: 22,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            PrimaryText(
                              'We work with monitoring programmes to ensure compliance with safety, health and quality standards for our products.',
                              maxLines: 3,
                              fontSize: 16,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            PrimaryText(
                              S.of(context).care.toUpperCase(),
                              fontSize: 22,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            PrimaryText(
                              'To keep your jackets and coats clean, you only need to freshen them up and go over them with a cloth or a clothes brush. If you need to dry clean a garment, '
                              'look for a dry cleaner that uses technologies that are respectful of the environment.',
                              fontSize: 16,
                              maxLines: 3,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            PrimaryText(
                              S.of(context).care.toUpperCase(),
                              fontSize: 18,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                ...List.generate(
                                  logic.state.shippingOptions.length,
                                  (index) => Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            logic.state.shippingOptions[index]
                                                    ['icon'] ??
                                                Icons.help_outline,
                                            size: 35,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      PrimaryText(
                                                        logic.state.shippingOptions[
                                                                    index]
                                                                ["title"] ??
                                                            '',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18,
                                                      ),
                                                      logic.state.isDropdownOpenList[
                                                              index]
                                                          ? Container(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  PrimaryText(
                                                                    logic.state.shippingOptions[index]
                                                                            [
                                                                            'content'] ??
                                                                        '',
                                                                    softWrap:
                                                                        true,
                                                                  ),
                                                                  PrimaryText(logic
                                                                          .state
                                                                          .shippingOptions[index]['date'] ??
                                                                      ''),
                                                                ],
                                                              ),
                                                            )
                                                          : SizedBox(),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () =>
                                                logic.toggleDropdown2(index),
                                            icon: logic.state
                                                    .isDropdownOpenList[index]
                                                ? Icon(
                                                    Icons
                                                        .keyboard_arrow_up_outlined,
                                                    size: 40,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .keyboard_arrow_down_outlined,
                                                    size: 40,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                  ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment
                                            .centerRight, // Căn lề trái
                                        child: Container(
                                          width: 310,
                                          // Điều chỉnh chiều dài của thanh gạch
                                          height: 1,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          margin: EdgeInsets.only(
                                              top: 8), // Cách lề trên một chút
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                logic.state.isLoading.value
                                    ? SizedBox.shrink()
                                    : AlsoLikeSection(
                                        title: S.of(context).youMayAlsoLike,
                                        products: logic.state.products,
                                        onTap: (id) {
                                          Get.delete<ProductDetailLogic>();
                                          Get.offAndToNamed(
                                              Routes.product_detail.p,
                                              arguments: id);
                                        },
                                      ),
                                SizedBox(
                                  height: 30,
                                ),
                                Align(
                                  alignment: Alignment.center, // Căn lề trái
                                  child: Container(
                                    width:
                                        200, // Điều chỉnh chiều dài của thanh gạch
                                    height: 1,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    margin: EdgeInsets.only(
                                        top: 8), // Cách lề trên một chút
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    PrimaryText(
                                      'support@openui.design',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    PrimaryText(
                                      '+60 825 876',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    PrimaryText(
                                      '08:00 - 22:00 - Everyday',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ],
                                ),
                                Footer(),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
