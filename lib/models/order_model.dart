import 'package:ecomercy_app_flutter/models/address_model.dart';
import 'package:ecomercy_app_flutter/models/order_product_model.dart';

enum OrderStatus {
  pendingConfirmation, // Chờ xác nhận
  pendingShipment,     // Chờ vận chuyển
  delivering,          // Đang giao hàng
  delivered,           // Giao hàng thành công
}

class OrderModel {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double totalAmount;
  final AddressModel shippingAddress;
  final String paymentMethod;   // Ví dụ: "COD", "Credit Card", "Momo"
  final DateTime createdAt;
  final OrderStatus status;

        // Ví dụ: "pending", "shipped", "delivered", "cancelled"

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.createdAt,
    required this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['userId'],
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      shippingAddress: AddressModel.fromJson(json['shippingAddress'] as Map<String, dynamic>),
      paymentMethod: json['paymentMethod'],
      createdAt: DateTime.parse(json['createdAt']),
      status: OrderStatusExtension.fromString(json['status'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userInfo': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'shippingAddress': shippingAddress,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt.toIso8601String(),
      'status': status.toFirebaseString(),
    };
  }

  @override
  String toString() {
    return 'OrderModel(\n'
        '  id: $id,\n'
        '  userId: $userId,\n'
        '  items: $items,\n'
        '  totalAmount: $totalAmount,\n'
        '  shippingAddress: $shippingAddress,\n'
        '  paymentMethod: $paymentMethod,\n'
        '  createdAt: $createdAt,\n'
        '  status: $status\n'
        ')';
  }
}

extension OrderStatusExtension on OrderStatus {
  static OrderStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pendingconfirmation':
      case 'chờ xác nhận': return OrderStatus.pendingConfirmation;
      case 'pendingshipment':
      case 'chờ vận chuyển': return OrderStatus.pendingShipment;
      case 'delivering':
      case 'đang giao hàng': return OrderStatus.delivering;
      case 'delivered':
      case 'thành công':
      case 'giao hàng thành công': return OrderStatus.delivered;
      default: return OrderStatus.pendingConfirmation;
    }
  }

  String toFirebaseString() {
    switch (this) {
      case OrderStatus.pendingConfirmation: return 'pendingConfirmation';
      case OrderStatus.pendingShipment: return 'pendingShipment';
      case OrderStatus.delivering: return 'delivering';
      case OrderStatus.delivered: return 'delivered';
    }
  }

  String toVietnamese() {
    switch (this) {
      case OrderStatus.pendingConfirmation: return 'Chờ xác nhận';
      case OrderStatus.pendingShipment: return 'Chờ lấy hàng';
      case OrderStatus.delivering: return 'Đang vận chuyển';
      case OrderStatus.delivered: return 'Hoành thành';
    }
  }
}

extension OrderStatusParser on String {
  OrderStatus toOrderStatus() {
    switch (this.toLowerCase()) {
      case 'pendingconfirmation':
        return OrderStatus.pendingConfirmation;
      case 'pendingshipment':
        return OrderStatus.pendingShipment;
      case 'delivering':
        return OrderStatus.delivering;
      case 'delivered':
        return OrderStatus.delivered;
      default:
        return OrderStatus.pendingConfirmation; // fallback nếu không khớp
    }
  }
}
