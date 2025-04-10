import 'package:ecomercy_app_flutter/routes/route.dart';
import 'package:ecomercy_app_flutter/widgets/text/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../configs/styles/themes/themes.dart';
import '../../widgets/app_bar/primary_appbar.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: PrimaryBigAppBar(
              title: 'Cá nhân',
              actions: [
                IconButton(
                  icon: Icon(Icons.settings_outlined, color: Colors.white),
                  onPressed: () { Get.toNamed(Routes.setting.p);},
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.chat_outlined, color: Colors.white),
                  onPressed: () {},
                ),
              ],
              bottomContent: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(right: 16),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: Colors.white.withOpacity(0.7)),
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
                      PrimaryText("Ngọc Dũng", color: Colors.white,),
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
                              "Thành viên ",
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
              color: Theme.of(context).colorScheme.primary,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryText(
                        "Đơn mua",
                        fontSize: 12,
                      ),
                      PrimaryText(
                        "Xem lịch sử mua hàng >",
                        fontSize: 12,
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.wallet,
                              size: 22,
                            ),
                            PrimaryText(
                              "Chờ xác nhận",
                              fontSize: 10,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.boxesPacking,
                              size: 22,
                            ),
                            PrimaryText(
                              "Chờ lấy hàng",
                              fontSize: 10,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.truck,
                              size: 22,
                            ),
                            PrimaryText(
                              "Chờ giao hàng",
                              fontSize: 10,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.solidStar,
                              size: 22,
                            ),
                            PrimaryText(
                              "Chờ xác nhận",
                              fontSize: 10,
                            ),
                          ],
                        )
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
              color: Theme.of(context).colorScheme.primary,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryText(
                        "Tiện ích",
                        fontSize: 12,
                      ),
                      SizedBox(),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.wallet,
                              size: 22,
                            ),
                            PrimaryText(
                              "Ví điện tử",
                              fontSize: 10,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.ticket,
                              size: 22,
                            ),
                            PrimaryText(
                              "Kho voucher",
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
                              "Thành viên",
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
                              "Đã thích",
                              fontSize: 10,
                            ),
                          ],
                        )
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
              color: Theme.of(context).colorScheme.primary,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryText(
                        "Hỗ trợ",
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
                                PrimaryText("Hỗ trợ"),
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
                                PrimaryText("Trò chuyện với nhân viên"),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  color: Theme.of(context).colorScheme.onPrimary,
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
            child: Padding(
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
            ),
          ),
        ],
      ),
    );
  }
}
