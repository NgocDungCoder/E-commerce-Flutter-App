import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route.dart';
import '../../views/cart/cart_logic.dart';

class PrimaryScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? title;
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  PrimaryScaffold({super.key, this.body, this.title});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartLogic>();
    return Scaffold(
      // key: scaffoldKey,
      // drawer:  FractionallySizedBox(
      //   widthFactor: 0.6, // 60% chiều rộng màn hình
      //   child: Drawer(
      //     child: ListView(
      //       children: [
      //         DrawerHeader(child: Text("Menu")),
      //         ListTile(title: Text("Trang chủ"), onTap: () {}),
      //       ],
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return Navigator.of(context).canPop()
                ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            )
                : IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Scaffold.of(context).openDrawer(); // Dùng context đúng của Scaffold
              },
            );
          },
        ),
        title: title ?? Text('E-commerce'),

        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
        centerTitle: true,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          Obx(
            () => Stack(
              clipBehavior: Clip.none,
              // Cho phép số lượng hiển thị bên ngoài Stack
              children: [
                Positioned(
                  left: -40, // Điều chỉnh vị trí sang trái

                  child: IconButton(
                      onPressed: () {
                        print("tìm kiếm");
                      },
                      icon: Icon(
                        Icons.search_outlined,
                        size: 30,
                      )),
                ),
                IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.cart.sp);
                  },
                  icon: Icon(Icons.shopping_cart_outlined),
                ),
                Positioned(
                  right: 5,
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
        ],
      ),
      body: body,
    );
  }
}
