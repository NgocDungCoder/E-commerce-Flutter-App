import 'package:ecomercy_app_flutter/models/order_model.dart';
import 'package:ecomercy_app_flutter/models/order_product_model.dart';
import 'package:ecomercy_app_flutter/routes/route.dart';
import 'package:ecomercy_app_flutter/services/address_service.dart';
import 'package:ecomercy_app_flutter/services/order_service.dart';
import 'package:ecomercy_app_flutter/utils/format_price.dart';
import 'package:ecomercy_app_flutter/utils/printLog.dart';
import 'package:ecomercy_app_flutter/views/cart/cart_logic.dart';
import 'package:ecomercy_app_flutter/views/checkout/checkout_state.dart';
import 'package:ecomercy_app_flutter/views/voucher/voucher_view.dart';
import 'package:get/get.dart';

import '../../models/address_model.dart';
import '../../models/voucher_model.dart';

class CheckoutLogic extends GetxController {
  final CartLogic cartLogic = Get.find<CartLogic>();
  final addressService = AddressService();
  final orderService = OrderService();
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

  Future<void> addNewOrder(String uid) async {
    state.isLoadingPayment.value = true;
    AddressModel address = AddressModel(
      name: state.addresses[state.selectedAddress.value].name,
      phone: state.addresses[state.selectedAddress.value].phone,
      street: state.addresses[state.selectedAddress.value].street,
      district: state.addresses[state.selectedAddress.value].district,
      isSelected: state.addresses[state.selectedAddress.value].isSelected,
    );

    // Chuyển trực tiếp từ cartLogic.state.productsOfCart thành danh sách các Map<String, dynamic>
    List<Map<String, dynamic>> orderItemsMap = cartLogic.state.productsOfCart.map((e) {
      return {
        'productID': e['productID'],  // Lấy 'productID' từ Map
        'quantity': e['quantity'],    // Lấy 'quantity' từ Map
      };
    }).toList();

// In ra để kiểm tra
    orderItemsMap.forEach((item) {
      print('Product ID: ${item['productID']}, Quantity: ${item['quantity']}');
    });

      // Tạo đơn hàng
      final orderData = {
        'userId': uid,
        'items': orderItemsMap,
        'totalAmount': subTotalAfterDiscount(),
        'shippingAddress': address.toJson(),
        'discount': discountPrice(),
        'paymentMethod': state.paymentMethods[state.defaultValue.value-1],
        'createdAt': DateTime.now().toString(),
        'status': OrderStatus.pendingConfirmation.toFirebaseString(),
      };


      try {
        state.orderId.value = await orderService.addNewOrder(uid, orderData);
        print(state.orderId.value);
      } on Exception catch (e) {
        print("Lỗi catche $e");
      }
    state.isLoadingPayment.value = false;
    }

  void goToSelectVoucher() async {
    // Truyền voucher và index vào argument
    final result = await Get.toNamed(Routes.voucher.p, arguments: {
      'voucher': state.voucher.value,
      'index': state.selectedVoucher.value,
    });

    // Kiểm tra kết quả trả về từ màn hình chọn voucher
    if (result != null && result is Map<String, dynamic>) {
      final Voucher selectedVoucher = result['voucher'];
      final int selectedIndex = result['index'];

      // Cập nhật lại voucher và index trong màn hình thanh toán
      state.voucher.value = selectedVoucher;
      state.selectedVoucher.value = selectedIndex;
      state.hasVoucher.value = true;

      print("Voucher đã chọn: ${selectedVoucher.name}, Index: $selectedIndex");
    } else {
      state.hasVoucher.value = false;
    }
  }

  double discountPrice() {
    double subTotal = cartLogic.state.subTotal.value.toDouble();
    if(state.hasVoucher.value) {
      subTotal = subTotal * state.voucher.value.discount/100;
      return subTotal;
    } else {
      return 0;
    }
  }

  double subTotalAfterDiscount() {
    double subTotal = cartLogic.state.subTotal.value.toDouble();
    if(state.hasVoucher.value) {
      subTotal -= subTotal * state.voucher.value.discount/100;
      return subTotal;
    } else {
      return subTotal;
    }
  }

}
