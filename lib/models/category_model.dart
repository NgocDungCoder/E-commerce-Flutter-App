import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Category(
      id: doc.id,               // id lấy từ doc id
      name: data['name'] ?? '', // name lấy trong data
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
