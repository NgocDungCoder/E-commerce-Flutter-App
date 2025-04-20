import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';

class UserService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final UserModel demoUser;

  @override
  void onInit() {
    super.onInit();
  }

  Future<Map<String, dynamic>?> getUserById(String userId) async {
    try {
      DocumentSnapshot snapshot =
      await _firestore.collection('users').doc(userId).get();

      // Kiểm tra xem tài liệu có tồn tại không
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        print("Không tìm thấy user với ID: $userId");
        return null; // Trả về null nếu không tìm thấy
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu user: $e");
      return null; // Trả về null nếu có lỗi
    }
  }

}
