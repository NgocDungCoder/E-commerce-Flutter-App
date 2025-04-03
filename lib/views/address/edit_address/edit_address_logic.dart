import 'package:ecomercy_app_flutter/utils/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../models/address_model.dart';
import '../../../services/address_service.dart';
import '../../checkout/checkout_logic.dart';
import 'edit_address_state.dart';

class EditAddressLogic extends GetxController{
  final int index = Get.arguments;
  final  state = EditAddressState();
  late final CheckoutLogic checkout;
  final addressService = AddressService();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final streetController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    checkout = Get.find<CheckoutLogic>(); // Tìm kiếm controller đúng cách
    final AddressModel address = checkout.state.addresses[index];
    setInitialData(initName: address.name, initPhone: address.phone, initStreet: address.street);
    state.name.value = address.name;
    state.phone.value = address.phone;
    state.district.value = address.district;
    state.street.value = address.street;
    state.isDefaut.value = address.isSelected;
    print(nameController.text);
    print(streetController.text);

    // Gán dữ liệu cũ vào TextField
  }

  void updateAddress() {
    var newAddress = AddressModel(
      name: nameController.text,
      phone: phoneController.text,
      district: state.district.value,
      street: streetController.text,
      isSelected: state.isDefaut.value,
    );

    // Nếu isDefault là true, lọc lại danh sách địa chỉ, reset isSelected của tất cả các địa chỉ
    if (state.isDefaut.value) {
      // Đặt isSelected = false cho tất cả các địa chỉ hiện có
      print(checkout.state.addresses.toString());

      checkout.state.addresses.forEach((address) {
        address.isSelected = false;
      });
    }
    checkout.state.addresses.removeAt(index);

    checkout.state.addresses.insert(index, newAddress);

    addressService.saveAddresses(checkout.state.addresses);

    checkout.loadAddresses();

    Get.back(); // Quay lại màn trước sau khi lưu
  }

  void removeAddress() {
    checkout.state.addresses.removeAt(index);

    addressService.saveAddresses(checkout.state.addresses);

    checkout.loadAddresses();
  }

  void setInitialData({
    required String initName,
    required String initPhone,
    required String initStreet,
  }) {
    nameController.text = initName;
    phoneController.text = initPhone;
    streetController.text = initStreet;
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    streetController.dispose();
    super.onClose();
  }

  void toggleDefault(bool value) {
    state.isDefaut.value = value;
  }

}