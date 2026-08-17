import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_blog_app/data/blog_database.dart';
import 'package:firebase_blog_app/data/blog_post_model.dart';
import 'package:firebase_blog_app/data/google_login.dart';
import 'package:firebase_blog_app/screen/widget/add_blog_post.dart';
import 'package:firebase_blog_app/screen/widget/edit_blog_Post.dart';
import 'package:flutter/material.dart';

import 'widget/blog_post_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final BlogDatabase blogDatabase =
      BlogDatabase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addBlogPostDialog,
      ),
      appBar: AppBar(title: Text("Blog App"),actions: [
        IconButton(onPressed: (){
          signInWithGoogle();
        }, icon: Icon(Icons.person))
      ],),
      body: StreamBuilder<QuerySnapshot<BlogPostModel>>(
        stream: blogDatabase.readBlog(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data?.docs;

            return ListView.builder(
              itemBuilder: (_, i) {
                final BlogPostModel? blogDoc =
                    data?[i].data() ;
                final String? docId=data?[i].id;
                if(docId==null||blogDoc==null) return SizedBox.shrink();
                return BloPostItem(blogDoc: blogDoc,docId: docId,);
              },
              itemCount: data?.length,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something Wrong"),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void _addBlogPostDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddBlogPost();
      },
    );
  }

}


