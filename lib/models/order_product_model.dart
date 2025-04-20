class OrderItem {
  final String productId;
  final int quantity;

  OrderItem({
    required this.productId,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productID'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return 'OrderItem(productID: $productId, quantity: $quantity)';
  }
}
