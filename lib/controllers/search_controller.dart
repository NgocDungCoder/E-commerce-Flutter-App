import 'package:get/get.dart';
import 'package:diacritic/diacritic.dart'; // Đảm bảo bạn đã cài package này trong pubspec.yaml


class SearchLogic extends GetxController {
  var isSearching = false.obs;
  var searchText = ''.obs;

  // List sản phẩm cần tìm (bạn có thể truyền vào từ bên ngoài)
  final products = <Map<String, dynamic>>[].obs;
  var isAllShown = false.obs;

  void clearSearch() {
    searchText.value = '';
    isSearching.value = false;
  }

  void startSearch() {
    isSearching.value = true;
  }

  void updateKeyword(String value) {
    searchText.value = value;
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) searchText.value = '';
  }

  List<Map<String, dynamic>> filterProducts(String keyword) {
    if (keyword.isEmpty) return allProducts;

    // Chuẩn hóa keyword (xóa dấu, bỏ khoảng trắng, chuyển sang chữ thường)
    String normalize(String input) {
      // Loại bỏ dấu tiếng Việt, chuyển thành chữ cái không dấu
      String noDiacritics = removeDiacritics(input);
      // Bỏ dấu cách và chuyển sang chữ thường
      String normalized = noDiacritics.replaceAll(RegExp(r'\s+'), '').toLowerCase();
      return normalized;
    }

    String normalizedKeyword = normalize(keyword);

    return allProducts.where((product) {
      String productName = product['name'].toString();
      String normalizedProductName = normalize(productName);
      return normalizedProductName.contains(normalizedKeyword);
    }).toList();
  }

  final allProducts = <Map<String, String>>[
    {'name': 'Quần short nữ'},
    {'name': 'Thắt lưng da'},
    {'name': 'Giày lười nam'},
    {'name': 'Áo khoác dạ'},
    {'name': 'Bộ đồ thể thao'},
    {'name': 'Kính râm'},
    {'name': 'Mũ lưỡi trai'},
    {'name': 'Váy công sở'},
    {'name': 'Tất (vớ)'},
    {'name': 'Dép sandal'},
    {'name': 'Áo len nữ'},
    {'name': 'Balo laptop'},
    {'name': 'Áo thun nam'},
    {'name': 'Giày cao gót'},
    {'name': 'Đồng hồ đeo tay'},
    {'name': 'Quần thể thao'},
    {'name': 'Quần jogger'},
    {'name': 'Áo vest nam'},
    {'name': 'Áo sơ mi nam'},
    {'name': 'Áo hoodie'},
    {'name': 'Găng tay da'},
    {'name': 'Quần jean nữ'},
    {'name': 'Túi xách nữ'},
    // thêm khoảng 30 sản phẩm khác cho đa dạng
    {'name': 'Balo du lịch'},
    {'name': 'Áo gió nam'},
    {'name': 'Áo tank top'},
    {'name': 'Giày chạy bộ'},
    {'name': 'Giày búp bê'},
    {'name': 'Ví da nam'},
    {'name': 'Khăn quàng cổ'},
    {'name': 'Mũ len'},
    {'name': 'Váy maxi'},
    {'name': 'Áo croptop'},
    {'name': 'Bộ đồ ngủ'},
    {'name': 'Áo cardigan'},
    {'name': 'Giày boots nữ'},
    {'name': 'Balo thể thao'},
    {'name': 'Áo polo nam'},
    {'name': 'Áo sơ mi nữ'},
    {'name': 'Dép tổ ong'},
    {'name': 'Quần baggy'},
    {'name': 'Áo thun oversize'},
    {'name': 'Áo khoác bomber'},
    {'name': 'Quần tây nam'},
    {'name': 'Túi tote'},
    {'name': 'Giày oxford'},
    {'name': 'Áo khoác da'},
    {'name': 'Áo blazer nữ'},
    {'name': 'Giày sandal nữ'},
    {'name': 'Mắt kính thời trang'},
    {'name': 'Dép kẹp nam'},
    {'name': 'Bộ đồ gym'},
    {'name': 'Túi đeo chéo nam'},
  ];
}
