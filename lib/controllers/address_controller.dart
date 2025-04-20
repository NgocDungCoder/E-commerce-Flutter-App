import 'package:get/get.dart';
import '../models/address_model.dart';
import '../services/address_service.dart';


class AddressController extends GetxController {
  var addresses = <AddressModel>[].obs;
  final AddressService addressService = AddressService();

  @override
  void onInit() {
    super.onInit();
    loadAddresses();
  }

  // Tải danh sách địa chỉ từ Storage
  void loadAddresses() async{
    addresses.value = await addressService.getAddresses();
  }

  // Thêm địa chỉ mới
  void addAddress(AddressModel newAddress) {
    addresses.add(newAddress);
    addressService.saveAddresses(addresses);
  }

  void addAddressList(List<AddressModel> newAddresses) {
    addresses.addAll(newAddresses); // Thêm danh sách mới vào danh sách hiện tại
    addressService.saveAddresses(addresses);
  }

  // Sửa địa chỉ
  void editAddress(int index, AddressModel updatedAddress) {
    addresses[index] = updatedAddress;
    addressService.saveAddresses(addresses);
  }

  // Xóa địa chỉ
  void removeAddress(int index) {
    addresses.removeAt(index);
    addressService.saveAddresses(addresses);
  }
}
