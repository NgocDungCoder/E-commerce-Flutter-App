class AddressModel {
  final String name;
  final String phone;
  final String street;
  final String district;
  bool isSelected;

  AddressModel({
    required this.name,
    required this.phone,
    required this.street,
    required this.district,
    this.isSelected = false,
  });

  // Hàm copyWith để tạo một bản sao với giá trị mới
  AddressModel copyWith({
    String? name,
    String? phone,
    String? street,
    String? district,
    bool? isSelected,
  }) {
    return AddressModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      street: street ?? this.street,
      district: district ?? this.district,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  // Chuyển đối tượng thành JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'street': street,
      'district': district,
      'isSelected': isSelected,
    };
  }

  // Chuyển từ JSON về đối tượng
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      name: json['name'],
      phone: json['phone'],
      street: json['street'],
      district: json['district'],
      isSelected: json['isSelected'] ?? false, // Mặc định là false nếu không có
    );
  }
}
