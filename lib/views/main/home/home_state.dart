import 'package:get/get.dart';

import '../../../models/category_model.dart';
import '../../../models/product_model.dart';

class HomeState {
  var isLoading = false.obs; // Đang tải dữ liệu (cho refresh, load thêm)
  var products = <dynamic>[].obs; // Danh sách sản phẩm you also like,
  var currentTabIndex = 0.obs;
  RxList<Category> categories = <Category>[].obs;
  RxMap<String, List<Product>> productsByCategory = <String, List<Product>>{}.obs;
  var isLoading2 = false.obs;


  final List<String> tabTitles = [
    'All',
    'Apparel',
    'Dress',
    'Tshirt',
    'Bag',
  ];

  final List<List<String>> fakeData = [
    ['Sản phẩm All 1', 'Sản phẩm All 2', 'Sản phẩm All 3'],
    ['Sản phẩm Apparel 1', 'Sản phẩm Apparel 2'],
    ['Sản phẩm Dress 1'],
    ['Sản phẩm Tshirt 1', 'Sản phẩm Tshirt 2'],
    ['Sản phẩm Bag 1'],
  ];

  // List<String> categories = [
  //   'CFJx3pILpSw7AGnn35Td',
  //   'DpL9QmvouT1Yr1iuWv9N',
  //   'cyMJPuuuVAYDdNNk14Ey',
  //   'g09JeQYptZZDPv9sr6TY',
  //   'vh2t1IXJLeKazrXwwPBq',
  // ];

  List<String> tagList = [
    '#2021',
    '#spring',
    '#collection',
    '#fall',
    '#dress',
    '#autumncollection',
    '#openfashion',
  ];
  List<String> logo = [
    'assets/logo/chanel.png',
    'assets/logo/converse.png',
    'assets/logo/dior.png',
    'assets/logo/louis.png',
    'assets/logo/the-north-face.png',
    'assets/logo/versace.png',
  ];

}