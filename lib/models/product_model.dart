import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String image;
  final int price;
  final int discount;
  final bool isDiscount;
  final int sold;
  final String categoryId;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.discount,
    required this.isDiscount,
    required this.sold,
    required this.categoryId,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: json['price'] ?? 0,
      discount: json['discount'] ?? 0,
      isDiscount: json['isDiscount'] ?? false,
      sold: json['sold'] ?? 0,
      categoryId: json['categoryId'] ?? '',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'discount': discount,
      'isDiscount': isDiscount,
      'sold': sold,
      'categoryId': categoryId,
      'createdAt': createdAt,
    };
  }
}
