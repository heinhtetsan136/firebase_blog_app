import 'package:cloud_firestore/cloud_firestore.dart';

class BlogDatabase {
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection(
        "blog",
      );
  final Stream<QuerySnapshot> _blogPostStream = FirebaseFirestore
      .instance
      .collection('blog')
      .snapshots();
  Future<DocumentReference?> createBlogPost({
    required String title,
    required String description,
  }) async {
    try {
      final DateTime dateTime = DateTime.now();
      final response = await _firestore.add({
        "title": title,
        "description": description,
        "createdAt":
            dateTime.microsecondsSinceEpoch,
      });
      return response;
    } catch (e) {
      Future.error(e);
    }
    return null;
  }

  Stream<QuerySnapshot> readBlog() {
    try {
      return _blogPostStream;
    } catch (e) {
      return Stream.error(e);
    }
  }
}
