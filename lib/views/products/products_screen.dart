import 'package:ecomercy_app_flutter/configs/styles/theme.dart';
import 'package:ecomercy_app_flutter/routes/route.dart';
import 'package:ecomercy_app_flutter/views/products/product_logic.dart';
import 'package:ecomercy_app_flutter/widgets/Scaffold/primary_scaffold.dart';
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
                color: ThemeConfigs.background,
                child: Center(
                  child: Lottie.asset('assets/animations/cat_loading.json',
                      width: 150, height: 150),
                ),
              )
            : RefreshIndicator(
                onRefresh: controller.refreshUser,
                child: Container(
                  color: ThemeConfigs.background,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView(
                      controller: controller.scrollController,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "${controller.state.totalProducts} sản phẩm",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.state.products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 0.58),
                          itemBuilder: (context, index) {
                            var product = controller.state.products[index];
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.product_detail.p,
                                    arguments: product['id']);
                                print(
                                    '=============PRODUCT SCREEN================>${product['id']}');
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: ThemeConfigs.whiteText,
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
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(15)),
                                          child: Image.network(
                                            product['image'],
                                            height: 230,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                const Icon(
                                                    Icons.image_not_supported),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            product['name'] ?? 'Tên sản phẩm',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: ThemeConfigs.text,
                                                fontSize: 14),
                                          ),
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                '${product['price'] ?? 'Giá bán'} đ',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: ThemeConfigs.redText,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                '${product['sold'] ?? 0} đã bán',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
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
                                                color: ThemeConfigs.whiteText,
                                                size: 14),
                                            const SizedBox(width: 3),
                                            Text(
                                              '${product['discount']} %',
                                              style: const TextStyle(
                                                  color: ThemeConfigs.whiteText,
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
                        ),
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
                                  onPressed: () =>
                                      controller.onPageSelected(pageNumber),
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
