import 'package:flutter/material.dart';

import '../../configs/styles/themes/themes.dart';
import '../Text/primary_text.dart';

class ProductItem extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(15),
            color: Theme.of(context)
                .colorScheme
                .primary,
            border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface,
                width: 1),
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                BorderRadius.vertical(
                    top: Radius.circular(
                        15)),
                child: Image.network(
                  product['image'],
                  height: 230,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context,
                      error,
                      stackTrace) =>
                      Icon(Icons
                          .image_not_supported),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets
                    .symmetric(
                    horizontal: 8.0),
                child: PrimaryText(
                    product['name'] ??
                        'Tên sản phẩm',
                    maxLines: 2,
                    fontSize: 15),
              ),
              Spacer(),
              Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets
                        .symmetric(
                        horizontal: 8.0),
                    child: PrimaryText(
                        '${product['price'] ?? 'Giá bán'} đ',
                        maxLines: 1,
                        color: Colors.pink,
                        fontSize: 13,
                        fontWeight:
                        FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets
                        .symmetric(
                        horizontal: 8.0),
                    child: PrimaryText(
                        '${product['sold'] ?? 0} đã bán',
                        maxLines: 1,
                        color: ThemeConfigs
                            .textSecondary(
                            context),
                        fontSize: 10),
                  ),
                ],
              )
            ],
          ),
        ),
        if (product['isDiscount'])
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding:
              const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4),
              decoration: const BoxDecoration(
                color: ThemeConfigs.redText,
                borderRadius:
                BorderRadius.only(
                  topRight:
                  Radius.circular(15),
                  bottomLeft:
                  Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                      Icons.local_offer,
                      color: ThemeConfigs
                          .whiteText,
                      size: 14),
                  const SizedBox(width: 3),
                  Text(
                    '${product['discount']} %',
                    style: const TextStyle(
                        color: ThemeConfigs
                            .whiteText,
                        fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
