import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addNewOrder(String uid, var orderData) async {
    try {

    final docRef = await _firestore
        .collection('users')
        .doc(uid)
        .collection('orders')
        .add(orderData);

    final orderId = docRef.id;
    print("docRef id: $orderId");
    return orderId;
    } on Exception catch (e) {
      print("Lỗi: $e");
      return "";
    }
  }

  Future<Map<String, dynamic>?> getOrderById(String userId, String orderId) async {
    try {
      // Truy cập trực tiếp tài liệu theo ID trong collection 'products'
      DocumentSnapshot snapshot = await _firestore
          .collection('users') // Collection người dùng
          .doc(userId) // Document của người dùng
          .collection('orders') // Sub-collection 'orders' của người dùng
          .doc(orderId) // Mã đơn hàng
          .get();


      // Kiểm tra xem tài liệu có tồn tại không
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        print("Không tìm thấy order với ID: $orderId");
        return null; // Trả về null nếu không tìm thấy
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu order: $e");
      return null; // Trả về null nếu có lỗi
    }
  }


}