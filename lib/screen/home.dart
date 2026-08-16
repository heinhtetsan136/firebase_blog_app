import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_blog_app/data/blog_database.dart';
import 'package:firebase_blog_app/screen/widget/add_blog_post.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text("Blog App")),
      body: StreamBuilder<QuerySnapshot>(
        stream: blogDatabase.readBlog(),
        builder: (_, snapshot) {
          if(snapshot.hasData){
            final data=snapshot.data?.docs;
            return ListView.builder(itemBuilder: (_,i){
              final Map blogDoc=data?[i].data() as Map;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(

                  elevation: 0,
                  child: ListTile(
                    title:Text(blogDoc["title"] ??""),
                  subtitle: Text(blogDoc["description"] ??""),),
                ),
              );
            },itemCount: data?.length,);

          }
          else if(snapshot.hasError){
            return Center(
              child:
                Text("Something Wrong")
              ,
            );
          }
          else{
            return CircularProgressIndicator();
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
