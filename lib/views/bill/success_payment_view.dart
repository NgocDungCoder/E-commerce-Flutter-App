import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:get/get.dart';
import '../../configs/styles/themes/themes.dart';
import '../../routes/route.dart';
import '../../widgets/Text/primary_text.dart';

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
      body: ListView(
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
                            Get.offNamed(Routes.products.p);
                          },
                          child: PrimaryText(
                            'Trang chủ',
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
                            Get.offNamed(Routes.billDetail.p, arguments: orderID);
                          },
                          child: PrimaryText(
                            'Đơn mua',
                            color: ThemeConfigs.whiteText,
                            fontSize: 15,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Center(
                  child: PrimaryText(
                    'Bạn có thể cũng thích'.toUpperCase(),
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 350,
                    height: 1,
                    color: Theme.of(context).colorScheme.onSurface,
                    margin: EdgeInsets.only(top: 8),
                  ),
                ),
                SizedBox(height: 15,),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.57,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context).colorScheme.primary,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.onSurface,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15)),
                                  child: Image.network(
                                    "https://drive.usercontent.google.com/download?id=1o_9pf1LhTZ1luk3Pcq6u2FJe66X5rsg8&export=view&authuser=0",
                                    height: 230,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Icon(Icons.image_not_supported),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: PrimaryText(
                                    'Tên sản phẩm',
                                    maxLines: 1,
                                    fontSize: 15,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: PrimaryText(
                                        'Giá bán',
                                        maxLines: 1,
                                        color: Colors.pink,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: PrimaryText(
                                        ' đã bán',
                                        maxLines: 1,
                                        color:
                                        ThemeConfigs.textSecondary(context),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          if (true)
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
                                        color: ThemeConfigs.whiteText, size: 14),
                                    const SizedBox(width: 3),
                                    Text(
                                      '25 %',
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
              ],
            ),
          )
        ],
      ),
    );
  }

}