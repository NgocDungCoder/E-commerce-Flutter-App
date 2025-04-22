import 'package:get/get.dart';

import '../../models/voucher_model.dart';

class VoucherState {
  var vouchers = <Voucher>[].obs;
  var isLoading = false.obs;
  var selectedVoucher = (-1).obs;
  var selectedShip = (-1).obs;
}