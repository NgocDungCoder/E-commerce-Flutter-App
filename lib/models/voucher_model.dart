import 'package:cloud_firestore/cloud_firestore.dart';

class Voucher {
  final String id;
  final String name;
  final String description;
  final double discount;
  final DateTime expiryDate;

  Voucher({
    required this.id,
    required this.name,
    required this.description,
    required this.discount,
    required this.expiryDate,
  });

  factory Voucher.fromJson(Map<String, dynamic> json, String id) {
    return Voucher(
      id: id,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      discount: (json['discount'] ?? 0).toDouble(),
      expiryDate: (json['expiryDate'] as Timestamp).toDate(),
    );
  }
}