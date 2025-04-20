import 'package:ecomercy_app_flutter/configs/styles/themes/themes.dart';
import 'package:ecomercy_app_flutter/utils/format_price.dart';
import 'package:ecomercy_app_flutter/views/order/order_logic.dart';
import 'package:ecomercy_app_flutter/widgets/Text/primary_text.dart';
import 'package:ecomercy_app_flutter/widgets/also_like/also_like_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../generated/l10n.dart';
import '../../models/order_model.dart';
import '../../routes/route.dart';
import '../product_detail/product_detail_logic.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderLogic>(() => OrderLogic());
  }
}

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<OrderLogic>(
      builder: (logic) {
        return logic.state.isLoading.value
            ? Center(
                child: Lottie.asset(
                  'assets/animations/load_more.json',
                  width: 150,
                  height: 150,
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: const PrimaryText(
                    "Đơn đã mua",
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.black,
                  leading: IconButton(
                    onPressed: Get.back,
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.white,
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(40),
                    child: _TabBar(logic: logic),
                  ),
                ),
                body: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: PageView.builder(
                    controller: logic.pageController,
                    itemCount: logic.state.tabs.length,
                    onPageChanged: (index) {
                      logic.state.currentTabIndex.value = index;
                      logic.animateToTab(index, context);
                    },
                    itemBuilder: (context, index) {
                      final orders = logic.state.categorizedOrders[index] ?? [];
                      return orders.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.orderDetail.p,
                                    arguments: orders[index].id);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: _OrderListView(
                                    orders: orders, logic: logic),
                              ),
                            )
                          : const _EmptyOrderView();
                    },
                  ),
                ),
              );
      },
    );
  }
}

// Widget hiển thị tab bar
class _TabBar extends StatelessWidget {
  final OrderLogic logic;

  const _TabBar({required this.logic});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: logic.scrollController,
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        height: 40,
        child: Obx(
          () => Row(
            children: List.generate(logic.state.tabs.length, (index) {
              final tab = logic.state.tabs[index];
              final isSelected = index == logic.state.currentTabIndex.value;
              logic.animateToTab(logic.state.currentTabIndex.value, context);
              // Đợi frame đầu render xong rồi mới gọi animateToTab

              return Padding(
                padding: const EdgeInsets.only(right: 25),
                child: GestureDetector(
                  onTap: () {
                    logic.animateToTab(index, context);
                    logic.pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isSelected ? Colors.red : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: PrimaryText(
                      tab,
                      color: isSelected ? Colors.pink : Colors.white,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// Widget hiển thị danh sách đơn hàng
class _OrderListView extends StatelessWidget {
  final List<dynamic> orders; // Thay dynamic bằng model Order nếu có
  final OrderLogic logic;

  const _OrderListView({required this.orders, required this.logic});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _OrderItem(order: order, logic: logic);
      },
    );
  }
}

// Widget hiển thị một đơn hàng
class _OrderItem extends StatelessWidget {
  final dynamic order; // Thay dynamic bằng model Order nếu có
  final OrderLogic logic;

  const _OrderItem({required this.order, required this.logic});

  @override
  Widget build(BuildContext context) {
    // Gọi fetchProductsInOrder một lần khi widget khởi tạo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logic.fetchProductsInOrder(order);
    });

    return Obx(() {
      final products = logic.state.orderProducts[order.id] ?? [];
      double subTotal = order.totalAmount.toDouble();
      OrderStatus status = order.status;
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimaryText(
                  "Ubuyee",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                PrimaryText(
                  status.toVietnamese(),
                  fontSize: 14,
                  color: Colors.pink,
                ),
              ],
            ),
            const SizedBox(height: 8),
            products.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      double price = product['price'].toDouble();
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            child: Image.network(
                              product['image'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryText(
                                  product['name'],
                                  fontSize: 13,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    PrimaryText(
                                      'XL',
                                      fontSize: 12,
                                      color:
                                          ThemeConfigs.textSecondary(context),
                                    ),
                                    PrimaryText("x${product['quantity']}",
                                        fontSize: 12,
                                        color: ThemeConfigs.textSecondary(
                                            context)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: PrimaryText(
                                    price.toCurrency(),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Spacer(),
                PrimaryText(
                  "Tổng số tiền (${products.length} sản phẩm): ",
                  fontSize: 13,
                ),
                PrimaryText(
                  subTotal.toCurrency(),
                  fontSize: 13,
                  fontWeight: FontWeight.bold, // Làm đậm giá tiền
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

// Widget hiển thị khi không có đơn hàng
class _EmptyOrderView extends StatelessWidget {
  const _EmptyOrderView();

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<OrderLogic>();
    return ListView(
      children: [
        SizedBox(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/order.json',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 15),
              const PrimaryText(
                "Bạn chưa có đơn hàng nào cả",
                fontSize: 13,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 35,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: AlsoLikeSection(
            title: S.of(context).youMayAlsoLike,
            products: logic.state.products,
            onTap: (id) {
              Get.delete<ProductDetailLogic>();
              Get.offAndToNamed(Routes.product_detail.p, arguments: id);
            },
          ),
        ),
      ],
    );
  }
}
