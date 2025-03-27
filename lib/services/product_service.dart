import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final int pageSize = 10; // Số sản phẩm mỗi trang
  List<DocumentSnapshot> cachedDocs = [];
  DocumentSnapshot? lastDocument;


  Future<int> getTotalProducts() async {
    QuerySnapshot snapshot = await _firestore.collection('products').get();
    return snapshot.size; // Lấy tổng số sản phẩm
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      QuerySnapshot snapshot =
      await _firestore.collection('products').limit(10).get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Lỗi khi lấy dữ liệu: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    try {
      QuerySnapshot snapshot =
      await _firestore.collection('categories').get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Lỗi khi lấy dữ liệu: $e");
      return [];
    }
  }
  
  Future<Map<String, dynamic>> fetchBlogs({DocumentSnapshot? lastDocument}) async {
    try {
      //snapshot: tìm hiểu sự khác nhau với query
      Query query = _firestore
          .collection("blogs")
          .orderBy("publishedDate", descending: true)
          .limit(5);

      // Nếu có lastDocument thì dùng để load tiếp dữ liệu
      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      QuerySnapshot querySnapshot = await query.get();
      if (querySnapshot.docs.isEmpty) return {"blogs": [], "lastDocument": null};

      return {
        "blogs": querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList(),
        "lastDocument": querySnapshot.docs.last // Lưu DocumentSnapshot cuối cùng
      };
    } catch (e) {
      print("Lỗi khi tải blogs: $e");
      print("Lỗi khi tải blogs: $e");
      return {"blogs": [], "lastDocument": null};
    }
  }
  
  Future<List<Map<String, dynamic>>> getRandomProducts() async {
    try {
      QuerySnapshot snapshot =
      await _firestore.collection('products').limit(10).get();

      List<Map<String, dynamic>> products = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      products.shuffle(); // Trộn danh sách ngẫu nhiên
      return products.take(4).toList();
    } catch (e) {
      print("Lỗi khi lấy dữ liệu: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchProducts(int page) async {
    Query query = FirebaseFirestore.instance.collection('products')
        .orderBy('createdAt', descending: true)
        .limit(10);
    // Nếu không phải trang đầu tiên, sử dụng startAtDocument
    if (page > 1 && cachedDocs.length >= (page - 1) * pageSize) {
      query = query.startAtDocument(cachedDocs[(page - 1) * pageSize - 1]);
    }

    QuerySnapshot snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      // Lưu lại dữ liệu để dùng khi chuyển trang
      cachedDocs.addAll(snapshot.docs);
    }

    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }


  Future<Map<String, dynamic>?> getProductById(String id) async {
    try {
      // Truy cập trực tiếp tài liệu theo ID trong collection 'products'
      DocumentSnapshot snapshot =
          await _firestore.collection('products').doc(id).get();

      // Kiểm tra xem tài liệu có tồn tại không
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        print("Không tìm thấy sản phẩm với ID: $id");
        return null; // Trả về null nếu không tìm thấy
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu sản phẩm: $e");
      return null; // Trả về null nếu có lỗi
    }
  }

  

  Future<List<Map<String, dynamic>>> getCartOfUser(String userId) async {
    QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("cart")
        .get();
    List<Map<String, dynamic>> cartItems = [];
    for (var doc in cartSnapshot.docs) {
      Map<String, dynamic> item =
          doc.data() as Map<String, dynamic>; // Lấy dữ liệu từ Firestore
      item['cartID'] = doc.id; // Thêm docId vào mỗi sản phẩm
      cartItems.add(item);
    }
    return cartItems; // Trả về danh sách sản phẩm
  }

  Future<void> addToCart(String userId, String productId, int quantity) async {
    try {
      // Lấy reference đến giỏ hàng trong Firestore
      CollectionReference cartRef = FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("cart");

      // Kiểm tra xem sản phẩm đã có trong giỏ chưa
      QuerySnapshot query =
          await cartRef.where("productID", isEqualTo: productId).get();

      if (query.docs.isNotEmpty) {
        // Nếu sản phẩm đã có -> Cập nhật số lượng
        DocumentSnapshot doc = query.docs.first;
        int currentQuantity = doc["quantity"];
        await cartRef
            .doc(doc.id)
            .update({"quantity": currentQuantity + quantity});
      } else {
        // Nếu sản phẩm chưa có -> Thêm mới
        await cartRef.add({
          "productID": productId,
          "quantity": quantity,
          "addedAt": FieldValue.serverTimestamp(),
        });
      }

      Get.snackbar("Thành công", "Sản phẩm đã được thêm vào giỏ hàng!",
          duration: Duration(seconds: 1),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      print("Lỗi khi thêm vào giỏ hàng: $e");
      Get.snackbar("Lỗi", "Không thể thêm sản phẩm vào giỏ hàng!",
          duration: Duration(seconds: 1),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> updateCartItemQuantity(
      String userId, String cartId, int newQuantity) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(cartId)
          .update({'quantity': newQuantity});

      print('Cập nhật số lượng thành công!');
    } catch (e) {
      print('Lỗi khi cập nhật số lượng: $e');
    }
  }

  Future<void> deleteProductFromCart(String cartId, String userId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("cart")
        .doc(cartId)
        .delete();
  }

  Future<void> addProducts() async {
    List<String> imageUrls = [
      "https://drive.usercontent.google.com/download?id=1qywv3_HAvOXbYWN3oTh-V0NJfd6Ummm5&export=view&authuser=0",
      "https://drive.usercontent.google.com/download?id=1wx58bFAzW4zEjR4b6c1S5F_ns0sqoSoB&export=view&authuser=0",
      "https://drive.usercontent.google.com/download?id=1o_9pf1LhTZ1luk3Pcq6u2FJe66X5rsg8&export=view&authuser=0",
      "https://drive.usercontent.google.com/download?id=1B7CNY0FdSw6UgEEQIPv1-bjFLyTjC0hy&export=view&authuser=0"
    ];

    List<String> productNames = [
      "Áo thun nam",
      "Quần jean nữ",
      "Giày thể thao",
      "Túi xách nữ",
      "Mũ lưỡi trai",
      "Kính râm",
      "Đồng hồ đeo tay",
      "Balo laptop",
      "Dép sandal",
      "Áo sơ mi nam",
      "Quần short nữ",
      "Giày cao gót",
      "Áo hoodie",
      "Quần thể thao",
      "Giày lười nam",
      "Tất (vớ)",
      "Thắt lưng da",
      "Áo len nữ",
      "Quần jogger",
      "Váy công sở",
      "Bộ đồ thể thao",
      "Túi đeo chéo",
      "Găng tay da",
      "Áo khoác dạ",
      "Áo vest nam"
    ];

    for (int i = 0; i < 25; i++) {
      var docRef = _firestore.collection('products').doc();

      int price = (50 + (i * 30)) * 1000; // Giá từ 50,000 đến khoảng 1,000,000
      int sold = (10 + i * 40); // Số lượt bán từ 10 - 1000
      bool isDiscount = i % 2 == 0; // Cứ 2 sản phẩm thì 1 cái có giảm giá
      int discount = isDiscount ? (5 + (i % 5) * 5) : 0; // Giảm 5-25% nếu có

      await docRef.set({
        "id": docRef.id,
        "image": imageUrls[i % imageUrls.length],
        "name": productNames[i % productNames.length],
        "price": price,
        "sold": sold,
        "isDiscount": isDiscount,
        "discount": discount,
        "createdAt": FieldValue.serverTimestamp(),
      });
    }

    print("✅ Đã thêm 25 sản phẩm vào Firestore!");
  }

  Future<void> addBlogs() async {
    final List<String> coverImages = [
      "https://drive.usercontent.google.com/download?id=1yB4kN2qu0gJXlZtAyvHmaOuymJ6b6mlH&export=view&authuser=0",
      "https://drive.usercontent.google.com/download?id=1oPtSTwh8kK6JAKqIJiZbhCQExc0l0mFM&export=view&authuser=0",
      "https://drive.usercontent.google.com/download?id=1vYKBm3NqxyE4nEYdV6rl91i97kT9sGKR&export=view&authuser=0",
      "https://drive.usercontent.google.com/download?id=1HB2dOrWHoOooGsCj7IVzVuRt57hxJfpo&export=view&authuser=0",
      "https://drive.usercontent.google.com/download?id=1PD0UdSjPCIldfHZQJIaEPSlpx54ezB32&export=view&authuser=0"
    ];

    final List<String> tags = [
      "thời trang nam",
      "thời trang nữ",
      "giày dép",
      "phụ kiện",
      "mùa hè",
      "mùa đông",
      "trang phục công sở",
      "trang phục dạo phố"
    ];

    final List<String> blogTypes = [
      "Tin tức thời trang",
      "Hướng dẫn phối đồ",
      "Review sản phẩm",
      "Khuyến mãi"
    ];

    String generateSlug(String title) {
      return title
          .toLowerCase()
          .trim()
          .replaceAll(RegExp(r'[^\w\s-]'), '')
          .replaceAll(RegExp(r'\s+'), '-')
          .replaceAll(RegExp(r'-+'), '-');
    }

    final Random random = Random();

    for (int i = 1; i <= 25; i++) {
      String title = "Bài viết thời trang số $i";
      String slug = generateSlug(title);
      String coverImage = coverImages[random.nextInt(coverImages.length)];
      String blogType = blogTypes[random.nextInt(blogTypes.length)];
      List<String> blogTags = (tags.toList()..shuffle()).take(2 + random.nextInt(2)).toList();

      await _firestore.collection("blogs").doc(slug).set({
        "title": title,
        "slug": slug,
        "coverImage": coverImage,
        "tags": blogTags,
        "blogType": blogType,
        "publishedDate": Timestamp.now(),
      });

      print("Đã lưu: $title");
    }
  }
}
