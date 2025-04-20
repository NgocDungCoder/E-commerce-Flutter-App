import 'package:get_storage/get_storage.dart';
import '../models/address_model.dart';
import 'dart:convert';

class AddressService {
  final GetStorage storage = GetStorage();

  // Lưu danh sách địa chỉ
  void saveAddresses(List<AddressModel> addresses) {
    List<String> jsonAddresses = addresses.map((address) => jsonEncode(address.toJson())).toList();
    storage.write('addresses', jsonAddresses);
  }


  Future<List<AddressModel>> getAddresses() async {
    // Đọc dữ liệu từ storage dưới dạng List<dynamic>
    List<dynamic>? jsonAddresses = await storage.read<List<dynamic>>('addresses');

    if (jsonAddresses == null) return []; // Nếu không có địa chỉ, trả về danh sách rỗng.

    // Chuyển đổi từng phần tử của List<dynamic> thành List<String>
    List<String> stringAddresses = jsonAddresses.map((e) => e.toString()).toList();

    // Chuyển đổi từng chuỗi JSON thành AddressModel và trả về danh sách AddressModel
    return stringAddresses
        .map((json) => AddressModel.fromJson(jsonDecode(json))) // Giải mã chuỗi JSON thành đối tượng AddressModel
        .toList();
  }
}



