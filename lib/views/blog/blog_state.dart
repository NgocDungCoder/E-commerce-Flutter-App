import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BlogState {
  var isListView = false.obs;
  var blogs = <Map<String, dynamic>>[].obs;
  var categories = <dynamic>[].obs;
  var isLoading = false.obs;
  var isLoadmore = false.obs;
  var hasMore = true.obs;
  DocumentSnapshot? lastDocument;
}