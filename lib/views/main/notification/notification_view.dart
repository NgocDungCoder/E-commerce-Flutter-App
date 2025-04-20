import 'package:ecomercy_app_flutter/widgets/Text/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/l10n.dart';
import '../../../routes/route.dart';
import '../../cart/cart_logic.dart';

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartLogic>();
    return Scaffold(
      appBar: AppBar(
        title: PrimaryText(
          S.of(context).notification,
          color: Colors.white,
          fontSize: 18,
        ),
        backgroundColor: Colors.black,
        actions: [
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
                  icon: Icon(Icons.shopping_cart_outlined, color: Colors.white,),
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
                      : SizedBox.shrink(), // Không hiển thị nếu số lượng bằng 0
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {Get.toNamed(Routes.chat.p);},
              icon: Icon(
                Icons.chat_outlined,
                color: Colors.white,
              )),
        ],
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: Theme.of(context).colorScheme.primary,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.onPrimary),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    width: 55,
                    height: 55,
                    child: Center(
                        child: Icon(
                      Icons.local_offer_sharp,
                      size: 30,
                    )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimaryText(
                          "Khuyến mãi",
                          fontWeight: FontWeight.bold,
                        ),
                        PrimaryText(
                          "Bạn ơi! Deal hời đang đợi bạn. Truy cập vào trang web",
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    S.of(context).updateOrder,
                    fontSize: 12,
                  ),
                  PrimaryText(
                    S.of(context).readAll,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.primary,
              height: 600,
              child: Column(children: [
                Lottie.asset('assets/animations/cart.json',
                    width: 200, height: 200),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ))),
                    onPressed: () {
                      Get.toNamed(Routes.products.p);
                    },
                    child: PrimaryText(
                      S.of(context).shopNow,
                      fontSize: 12,
                    ))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
