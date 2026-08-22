import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_blog_app/data/blog_post_model.dart';

class BlogDatabase {
  final CollectionReference<BlogPostModel>
  _firestore = FirebaseFirestore.instance
      .collection("blog")
      .withConverter(
        fromFirestore: ((snapshot, options) {
          return BlogPostModel.fromJson(snapshot);
        }),
        toFirestore: (blogPost, options) {
          return blogPost.toJson();
        },
      );

  Future deletePost(String id) async {
    try {
      await _firestore.doc(id).delete();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future updatePost({
    required String docId,
    required BlogPostModel model,
  }) async {
    try {
      final dateTime =
          DateTime.now().microsecondsSinceEpoch;
      await _firestore
          .doc(docId)
          .update(model.toJson());
    } catch (e) {
      return Future.error(e);
    }
  }

  late final Stream<QuerySnapshot<BlogPostModel>>
  _blogPostStream = _firestore.snapshots();

  Future<DocumentReference?> createBlogPost({
    required BlogPostModel model,
  }) async {
    try {
      final User? user =
          FirebaseAuth.instance.currentUser;
      final String? userId = user?.uid;
      final DateTime dateTime = DateTime.now();
      if (userId == null) {
        Future.error("User not Authorized");
      }
      print(userId);
      final response = await _firestore.add(
        model.copyWith(userId: userId),
      );
      return response;
    } catch (e) {
      Future.error(e);
    }
    return null;
  }

  Stream<QuerySnapshot<BlogPostModel>>
  readBlog() {
    try {
      return _blogPostStream;
    } catch (e) {
      return Stream.error(e);
    }
  }
}
