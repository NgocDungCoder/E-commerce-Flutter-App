import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/products/product_logic.dart';

class PaginationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.find<ProductLogic>();
    final totalPages = 5; // Giả sử có 5 trang

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        final page = index + 1;
        return GestureDetector(
          onTap: () => logic.fetchProducts(logic.state.currentPage.value),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: logic.state.currentPage == page ? Colors.black : Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              '$page',
              style: TextStyle(color: logic.state.currentPage == page ? Colors.white : Colors.black),
            ),
          ),
        );
      }),
    );
  }
}
