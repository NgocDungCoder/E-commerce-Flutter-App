import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/voucher_model.dart';

class VoucherService {
  final _voucherRef = FirebaseFirestore.instance.collection('voucher');

  Future<List<Voucher>> getAllVouchers() async {
    try {
      final snapshot = await _voucherRef.get();
      return snapshot.docs.map((doc) => Voucher.fromJson(doc.data(), doc.id)).toList();
    } catch (e) {
      print("Lỗi khi lấy voucher: $e");
      return [];
    }
  }
}
