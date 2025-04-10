import 'dart:async';

import 'package:ecomercy_app_flutter/services/product_service.dart';
import 'package:ecomercy_app_flutter/views/blog/blog_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BlogLogic extends GetxController {
  final BlogState state = BlogState();
  final ProductService _blogService = ProductService();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() async{
    super.onInit();
    await refreshBlogs();
    await fetchCategories();
    scrollController.addListener(_onScroll);
  }
  void _onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
        !state.isLoading.value) {
      fetchBlogs(isLoadMore: true);
    }
  }

  Future<void> fetchCategories() async {
    List categories = await _blogService.getCategories();
    state.categories.addAll(categories);
  }

  void toggleListView() {
    state.isListView.value = !state.isListView.value;
  }

  Future<void> refreshBlogs() async {
    try{
      if(state.isLoading.value == true) return;
      state.isLoading.value = true;
      List<Map<String, dynamic>> newBlogs = await fetchBlogs();
      state.blogs.clear();
      state.blogs.addAll(newBlogs);
    } catch(e) {
      print("[LOG] Lỗi khi refesh Blogs: $e");

    } finally {
      state.isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    try{
      if(state.isLoadmore.value == true) return;
      state.isLoadmore.value = true;
      List<Map<String, dynamic>> newBlogs = await fetchBlogs();
      state.blogs.addAll(newBlogs);
    } catch(e) {
      print("[LOG] Lỗi khi refesh Blogs: $e");

    } finally {
      state.isLoadmore.value = false;
    }
  }

  Future<List<Map<String, dynamic>>> fetchBlogs({bool isLoadMore = false}) async {
    try {
      Map<String, dynamic> result = await _blogService.fetchBlogs(lastDocument: state.lastDocument);

      List<Map<String, dynamic>> newBlogs = result["blogs"];
      state.lastDocument = result["lastDocument"]; // Cập nhật lastDocument

      if(newBlogs.isNotEmpty){

        await Future.wait(newBlogs.map((product) async {
          try {
            final imageProvider = NetworkImage(product['coverImage']);
            final completer = Completer<void>();

            imageProvider.resolve(ImageConfiguration()).addListener(
              ImageStreamListener(
                    (imageInfo, _) => completer.complete(),
                onError: (error, stackTrace) {
                  print("⚠️ Lỗi tải ảnh: $error"); // In lỗi nếu ảnh tải thất bại
                  completer.complete();
                },
              ),
            );

            await completer.future;
          } catch (e) {
            print("⚠️ Lỗi khi xử lý ảnh: $e");
          }
        }));
        return newBlogs;
      }
    } on Exception catch (e) {
      print("Lỗi khi lấy dứ liệu blogs: $e");
    } finally {
      state.isLoading.value = false;
    }
    return [];

  }
}