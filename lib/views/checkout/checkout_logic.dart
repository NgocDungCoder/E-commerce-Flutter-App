import 'package:ecomercy_app_flutter/services/address_service.dart';
import 'package:ecomercy_app_flutter/views/cart/cart_logic.dart';
import 'package:ecomercy_app_flutter/views/checkout/checkout_state.dart';
import 'package:get/get.dart';

class CheckoutLogic extends GetxController {
  final CartLogic cartLogic = Get.find<CartLogic>();
  final addressService = AddressService();
  final state = CheckoutState();

  @override
  void onInit() {
    super.onInit();
    loadAddresses();
  }


  // Tải danh sách địa chỉ từ Storage
  void loadAddresses() async{
    try {
      state.addresses.value = await addressService.getAddresses();
      // Tìm địa chỉ có isSelected = true và lưu index của nó
      int defaultIndex = state.addresses.indexWhere((address) => address.isSelected);
      // Nếu tìm thấy địa chỉ được chọn (index != -1)
      if (defaultIndex != -1) {
        moveSelectedAddressToTop(defaultIndex);
      }
      state.isLoading.value = false;
      state.selectedAddress.value = 0;
    } on Exception catch (e) {
      print("Lỗi load địa chỉ: $e");
    }
  }

  void moveSelectedAddressToTop(int defaultIndex) {
    var selectedAddress = state.addresses[defaultIndex];
      state.addresses.remove(selectedAddress);
      state.addresses.insert(0, selectedAddress);
  }
}