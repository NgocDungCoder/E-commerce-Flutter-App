import 'package:ecomercy_app_flutter/routes/route.dart';
import 'package:ecomercy_app_flutter/views/main/profile/profile_logic.dart';
import 'package:ecomercy_app_flutter/widgets/text/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../configs/styles/themes/themes.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/also_like/also_like_section.dart';
import '../../../widgets/app_bar/primary_appbar.dart';
import '../../cart/cart_logic.dart';
import '../../order/order_view.dart';
import '../../product_detail/product_detail_logic.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileLogic>(() => ProfileLogic());
  }
}

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartLogic>();
    return Scaffold(
      body: GetX<ProfileLogic>(builder: (logic) {
        return Container(
          color: Theme.of(context).colorScheme.primary,
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: PrimaryBigAppBar(
                  title: S.of(context).profile,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.settings_outlined, color: Colors.white),
                      onPressed: () {
                        Get.toNamed(Routes.setting.p);
                      },
                    ),
                    Obx(
                      () => Stack(
                        clipBehavior: Clip.none,
                        // Cho phép số lượng hiển thị bên ngoài Stack
                        children: [
                          IconButton(
                            onPressed: () {
                              cartController.refreshCart();
                              Get.toNamed(Routes.cart.sp);
                            },
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: cartController.state.itemCount.value > 0
                                ? Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 17,
                                      minHeight: 17,
                                    ),
                                    child: Text(
                                      '${cartController.state.itemCount.value}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : SizedBox
                                    .shrink(), // Không hiển thị nếu số lượng bằng 0
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.chat_outlined, color: Colors.white),
                      onPressed: () {
                        Get.toNamed(Routes.chat.p);
                      },
                    ),
                  ],
                  bottomContent: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            child: GestureDetector(
                              onTap: () => Get.toNamed(Routes.editProfile.p),
                              child: Container(
                                margin: EdgeInsets.only(right: 16),
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.white.withOpacity(0.7)),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset(
                                    "assets/product9.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 11,
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(55),
                              ),
                              child: Icon(
                                FontAwesomeIcons.pencil,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          PrimaryText(
                            "Ngọc Dũng",
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Container(
                            padding:
                                EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                PrimaryText(
                                  S.of(context).member,
                                  color: Colors.black,
                                  fontSize: 9,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                  size: 9,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              // Nội dung bên dưới
              SliverToBoxAdapter(
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PrimaryText(
                            S.of(context).purchaseOrder, // "Đơn mua"
                            fontSize: 12,
                          ),
                          PrimaryText(
                            "${S.of(context).purchaseHistory} >",
                            // "Xem lịch sử mua hàng >"
                            fontSize: 12,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.order.p, arguments: {
                                  'orders': logic.state.categorizedOrders,
                                  'tabIndex': 0,
                                  // nếu cần truyền luôn tab đang active
                                });
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.wallet,
                                        size: 22,
                                      ),
                                      logic.state.pendingCount.value > 0
                                          ? Positioned(
                                              right: -15,
                                              top: -13,
                                              child: Container(
                                                padding: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                                constraints: const BoxConstraints(
                                                  minWidth: 18,
                                                  minHeight: 18,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    logic.state.pendingCount.value
                                                        .toString(),
                                                    // số lượng đơn chờ xác nhận (có thể dùng biến)
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox.shrink()
                                    ],
                                  ),
                                  PrimaryText(
                                    S.of(context).waitingForConfirmation,
                                    // "Chờ xác nhận"
                                    fontSize: 10,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.order.p, arguments: {
                                  'orders': logic.state.categorizedOrders,
                                  'tabIndex': 1,
                                  // nếu cần truyền luôn tab đang active
                                });
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.boxesPacking,
                                        size: 22,
                                      ),
                                      logic.state.pendingShipmentCount.value > 0
                                          ? Positioned(
                                              right: -15,
                                              top: -13,
                                              child: Container(
                                                padding: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                                constraints: const BoxConstraints(
                                                  minWidth: 18,
                                                  minHeight: 18,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    logic.state.pendingShipmentCount
                                                        .value
                                                        .toString(),
                                                    // số lượng đơn chờ xác nhận (có thể dùng biến)
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox.shrink()
                                    ],
                                  ),
                                  PrimaryText(
                                    S
                                        .of(context)
                                        .waitingForPickup, // "Chờ lấy hàng"
                                    fontSize: 10,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.order.p, arguments: {
                                  'orders': logic.state.categorizedOrders,
                                  'tabIndex': 2,
                                  // nếu cần truyền luôn tab đang active
                                });
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.truck,
                                        size: 22,
                                      ),
                                      logic.state.deliveringCount.value > 0
                                          ? Positioned(
                                              right: -15,
                                              top: -13,
                                              child: Container(
                                                padding: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                                constraints: const BoxConstraints(
                                                  minWidth: 18,
                                                  minHeight: 18,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    logic
                                                        .state.deliveringCount.value
                                                        .toString(),
                                                    // số lượng đơn chờ xác nhận (có thể dùng biến)
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox.shrink()
                                    ],
                                  ),
                                  PrimaryText(
                                    S
                                        .of(context)
                                        .waitingForDelivery, // "Chờ giao hàng"
                                    fontSize: 10,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.order.p, arguments: {
                                  'orders': logic.state.categorizedOrders,
                                  'tabIndex': 3,
                                  // nếu cần truyền luôn tab đang active
                                });
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.solidStar,
                                    size: 22,
                                  ),
                                  PrimaryText(
                                    S.of(context).rating, // "Chờ xác nhận"
                                    fontSize: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(
                height: 10,
              )),
              SliverToBoxAdapter(
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PrimaryText(
                            S.of(context).utilities, // "Tiện ích"
                            fontSize: 12,
                          ),
                          const SizedBox(),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              child: Column(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.wallet,
                                    size: 22,
                                  ),
                                  PrimaryText(
                                    S.of(context).eWallet, // "Ví điện tử"
                                    fontSize: 10,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Icon(
                                  FontAwesomeIcons.ticket,
                                  size: 22,
                                ),
                                PrimaryText(
                                  S.of(context).voucherStorage, // "Kho voucher"
                                  fontSize: 10,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  FontAwesomeIcons.medal,
                                  size: 22,
                                ),
                                PrimaryText(
                                  S.of(context).member, // "Thành viên"
                                  fontSize: 10,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  FontAwesomeIcons.solidHeart,
                                  size: 22,
                                ),
                                PrimaryText(
                                  S.of(context).liked, // "Đã thích"
                                  fontSize: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(
                height: 10,
              )),
              SliverToBoxAdapter(
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PrimaryText(
                            S.of(context).support,
                            fontSize: 12,
                          ),
                          SizedBox(),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.question,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    PrimaryText(S.of(context).support),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 13,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.center, // Căn lề trái
                              child: Container(
                                width: double.infinity,
                                // Điều chỉnh chiều dài của thanh gạch
                                height: 0.4,
                                color: Theme.of(context).colorScheme.onSurface,
                                margin: EdgeInsets.symmetric(vertical: 15),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.chat_outlined,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    PrimaryText(S.of(context).chatWithStaff),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 13,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.center, // Căn lề trái
                              child: Container(
                                width: double.infinity,
                                // Điều chỉnh chiều dài của thanh gạch
                                height: 0.4,
                                color: Theme.of(context).colorScheme.onSurface,
                                margin: EdgeInsets.symmetric(vertical: 15),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed(Routes.blogs.p),
                              child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.blog,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        PrimaryText("Ubuyee blog"),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 13,
                                      color:
                                          Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(
                height: 35,
              )),

              SliverToBoxAdapter(
                child: logic.state.isLoading.value
                    ? Center(
                        child: Lottie.asset('assets/animations/load_more.json',
                            width: 150, height: 150),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AlsoLikeSection(
                          title: S.of(context).youMayAlsoLike,
                          products: logic.state.products,
                          onTap: (id) {
                            Get.delete<ProductDetailLogic>();
                            Get.toNamed(Routes.product_detail.p, arguments: id);
                          },
                        ),
                      ),
              )
            ],
          ),
        );
      }),
    );
  }
}
