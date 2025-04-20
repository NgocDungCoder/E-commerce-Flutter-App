import 'package:get/get.dart';

import '../../../models/address_model.dart';
import '../../../services/address_service.dart';
import '../../checkout/checkout_logic.dart';
import 'add_address_state.dart';

class AddAddressLogic extends GetxController {
  final state = AddAddressState(); // Đảm bảo AddAddressState được khởi tạo đúng
  final addressService = AddressService();
  late final CheckoutLogic checkout;

  @override
  void onInit() {
    super.onInit();
    checkout = Get.find<CheckoutLogic>(); // Tìm kiếm controller đúng cách
  }


  void toggleDefault(bool value) {
    state.isDefaut.value = value;
  }

  void addNewAddress() {
    var newAddress = AddressModel(
      name: state.name.value,
      phone: state.phone.value,
      street: state.street.value,
      district: state.district.value,
      isSelected: state.isDefaut.value,
    );
    print(state.isDefaut.value);
    // Nếu isDefault là true, lọc lại danh sách địa chỉ, reset isSelected của tất cả các địa chỉ
    if (state.isDefaut.value) {
      // Đặt isSelected = false cho tất cả các địa chỉ hiện có
      print(checkout.state.addresses.toString());
      int i = 0;
      checkout.state.addresses.forEach((address) {
        address.isSelected = false;
      });
    }

    checkout.state.addresses.add(newAddress);

    addressService.saveAddresses(checkout.state.addresses);

    checkout.loadAddresses();

    Get.back(); // Quay lại màn trước sau khi lưu
  }

}
