import 'package:flutter/material.dart';
import '../Text/primary_text.dart';
import '../product_item/product_item.dart';

class AlsoLikeSection extends StatelessWidget {
  final String title;
  final List<dynamic> products;
  final void Function(String id) onTap;

  const AlsoLikeSection({
    super.key,
    required this.title,
    required this.products,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return SizedBox();

    return Column(
      children: [
        Center(
          child: PrimaryText(
            title.toUpperCase(),
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 250,
            height: 1,
            color: Theme.of(context).colorScheme.onSurface,
            margin: EdgeInsets.only(top: 8),
          ),
        ),
        SizedBox(height: 15),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.57,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () => onTap(product['id']),
              child: ProductItem(product: product),
            );
          },
        ),
      ],
    );
  }
}
