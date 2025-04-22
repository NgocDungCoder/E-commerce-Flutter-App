import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/search_controller.dart';
import '../../routes/route.dart';
import '../../views/cart/cart_logic.dart';
import '../Text/primary_text.dart';
import '../also_like/also_like_section.dart';
import '../custon_drawer/custom_drawer.dart';

class PrimaryScaffold extends StatefulWidget {
  final Widget? body;
  final Widget? title;

  PrimaryScaffold({
    super.key,
    this.body,
    this.title,
  });

  @override
  State<PrimaryScaffold> createState() => _PrimaryScaffoldState();
}

class _PrimaryScaffoldState extends State<PrimaryScaffold> {
  final menuKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartLogic>();
    final SearchLogic logic =
        Get.find<SearchLogic>(); // Hoặc truyền vào constructor

    return Scaffold(
      key: menuKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white,),
          onPressed: () {
            if (logic.isSearching.value) {
              logic.toggleSearch(); // Thực hiện hành động toggle search
            } else {
              Get.back(); // Quay lại màn hình trước
            }
          },
        ),
        title: Obx(() => logic.isSearching.value
            ? TextField(
                autofocus: true,
                onChanged: logic.updateKeyword,
                decoration: InputDecoration(
                  hintText: "Tìm kiếm...",
                  hintStyle: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.5,
                    letterSpacing: 1.5,
                  ),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.lora(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.5,
                  letterSpacing: 1.5,
                ),
              )
            : widget.title ??
                PrimaryText(
                  'OPEN FASHION',
                  color: Colors.white,
                  fontSize: 22,
                )),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
        centerTitle: true,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          Obx(() => IconButton(
              icon: Icon(logic.isSearching.value ? Icons.close : Icons.search),
              onPressed: logic.toggleSearch)),
          Obx(
            () => Stack(
              clipBehavior: Clip.none,
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
                      : SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Obx(() {
        // Lọc hoặc tìm kiếm theo searchText
        final filtered = logic.filterProducts(logic.searchText.value);
        return IndexedStack(
          index: logic.isSearching.value ? 0 : 1,
          children: [
            ListView(
              children: [
                filtered.length > 0
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: logic.isAllShown.value ? filtered.length : 4,
                        itemBuilder: (context, index) {
                          if (index >= filtered.length) {
                            return SizedBox
                                .shrink(); // Hoặc xử lý nếu vượt quá giới hạn
                          }
                          final product = filtered[index];
                          return ListTile(
                            title: PrimaryText(product['name']),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Align(
                          alignment: Alignment.centerRight, // Căn lề trái
                          child: Container(
                            width: double.infinity,
                            // Điều chỉnh chiều dài của thanh gạch
                            height: 0.6,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Align(
                            alignment: Alignment.center,
                            child: PrimaryText("Không tìm thấy sản phẩm nào"))),

                Align(
                  alignment: Alignment.centerRight, // Căn lề trái
                  child: Container(
                    width: double.infinity,
                    // Điều chỉnh chiều dài của thanh gạch
                    height: 0.6,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                filtered.length > 5
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              logic.isAllShown.toggle();
                            },
                            child: !logic.isAllShown.value
                                ? PrimaryText('Xem thêm')
                                : PrimaryText('Rút gọn'),
                          ),
                          Icon(logic.isAllShown.value
                              ? Icons.keyboard_arrow_up_outlined
                              : Icons.keyboard_arrow_down_outlined),
                        ],
                      )
                    : SizedBox.shrink(),
                // logic.isAllShown.value ? SizedBox.shrink() : AlsoLikeSection(title: 'Gợi ý sản phẩm', products: [], onTap: (String id) {  },),
              ],
            ),
            widget.body ?? SizedBox.shrink(),
          ],
        );
        // Khi không tìm kiếm, hiển thị body gốc
      }),
    );
  }
}
