import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:get/get.dart';
import '../../configs/styles/themes/themes.dart';
import '../../generated/l10n.dart';
import '../../routes/route.dart';
import '../../widgets/Text/primary_text.dart';
import '../../widgets/also_like/also_like_section.dart';
import '../product_detail/product_detail_logic.dart';
import 'order_detail_logic.dart';

class SuccessPaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderID = Get.arguments;
    print("orderId trong succses: $orderID");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: PrimaryText("Đặt hàng thành công", color: Colors.white,),
        centerTitle: true,
      ),
      body: GetX<OrderDetailLogic>(builder: (logic) {
        return ListView(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Center(child: PrimaryText("Đơn hàng đã được đặt thành công")),
                Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Lottie.asset('assets/animations/success.json',
                        width: 150, height: 150),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              // Bo góc
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Get.offNamed(Routes.main.p, arguments: 0);
                          },
                          child: PrimaryText(
                            S.of(context).home,
                            color: ThemeConfigs.whiteText,
                            fontSize: 15,
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              // Bo góc
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Get.offNamed(Routes.orderDetail.p, arguments: orderID);
                          },
                          child: PrimaryText(
                            S.of(context).order,
                            color: ThemeConfigs.whiteText,
                            fontSize: 15,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          logic.state.isLoading.value ? Center(
            child: Lottie.asset(
                'assets/animations/load_more.json',
                width: 150,
                height: 150),
          ) : Padding(
            padding: const EdgeInsets.all(10.0),
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
      );}),
    );
  }

}