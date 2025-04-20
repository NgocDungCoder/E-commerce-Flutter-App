import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route.dart';
import '../../views/cart/cart_logic.dart';
import '../Text/primary_text.dart';
import '../custon_drawer/custom_drawer.dart';

class PrimaryScaffold extends StatefulWidget {
  final Widget? body;
  final Widget? title;

  PrimaryScaffold({super.key, this.body, this.title});

  @override
  State<PrimaryScaffold> createState() => _PrimaryScaffoldState();
}

class _PrimaryScaffoldState extends State<PrimaryScaffold> {
  final menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartLogic>();
    return Scaffold(
      key: menuKey,
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return Navigator.of(context).canPop()
                ? IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Get.back(),
                  )
                : IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {
                      // if (menuKey.currentContext == null) {
                      //   print("⚠️ Menu Key chưa sẵn sàng!");
                      //   return;
                      // }
                      // showCustomDrawer(context, menuKey);
                      Get.offAllNamed(Routes.main.p);
                    },
                  );
          },
        ),
        title: widget.title ?? PrimaryText('OPEN FASHION', color: Colors.white, fontSize: 22,),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
        centerTitle: true,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: () {
                print("tìm kiếm");
              },
              icon: Icon(
                Icons.search_outlined,
                size: 30,
              )),
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
                  icon: Icon(Icons.shopping_cart_outlined),
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
        ],
      ),
      body: widget.body,
    );
  }
}
