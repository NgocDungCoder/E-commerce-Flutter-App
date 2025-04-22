import 'package:ecomercy_app_flutter/services/voucher_service.dart';
import 'package:ecomercy_app_flutter/views/voucher/voucher_state.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/voucher_model.dart';

class VoucherLogic extends GetxController {
  final state = VoucherState();
  final _voucherService = VoucherService();
  late final arguments;

  @override
  void onInit() async {
    super.onInit();
    arguments = Get.arguments;
    await fetchVouchers();

  }

  Future<void> fetchVouchers() async {
    state.isLoading.value = true;
    state.vouchers.value = await _voucherService.getAllVouchers();
    print("================================");
    print(state.vouchers.length);
    state.isLoading.value = false;
    if(arguments['index'] > -1){
      state.selectedVoucher.value = arguments['index'];
    }
  }

  String formatDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  void selectThisVoucher() {
    // Nếu chọn voucher hợp lệ
    if (state.selectedVoucher.value > -1) {
      final selectedVoucher = state.vouchers[state.selectedVoucher.value];
      final selectedIndex = state.selectedVoucher.value;
      // Trả về voucher và index
      Get.back(result: {'voucher': selectedVoucher, 'index': selectedIndex});
    } else {
      // Nếu không chọn voucher nào, trả về null
      Get.back(result: null);
    }
  }
}