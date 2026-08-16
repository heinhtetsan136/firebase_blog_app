import 'package:firebase_blog_app/data/blog_database.dart';
import 'package:flutter/material.dart';

class AddBlogPost extends StatefulWidget {
  const AddBlogPost({super.key});

  @override
  State<AddBlogPost> createState() =>
      _AddBlogPostState();
}

class _AddBlogPostState
    extends State<AddBlogPost> {
  final TextEditingController _titleController =
      TextEditingController();
  final TextEditingController
  _descriptionController =
      TextEditingController();
  BlogDatabase blogDatabase = BlogDatabase();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Title",
            ),
          ),
          SizedBox(height: 8),
          TextField(
            maxLines: 4,
            minLines: 2,
            controller: _descriptionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Description",
            ),
          ),
          SizedBox(height: 8),
          if (_isLoading)
            CircularProgressIndicator(),
        ],
      ),
      actions: [
        FilledButton(
          onPressed: () async {
            if (_isLoading) {
              return;
            }
            try {
              if (_titleController.text
                      .trim()
                      .isEmpty ||
                  _descriptionController.text
                      .trim()
                      .isEmpty) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      "Please fill all the fields",
                    ),
                  ),
                );
                return;
              } else {
                setState(() {
                  _isLoading = true;
                });
              }
              await blogDatabase.createBlogPost(
                title: _titleController.text,
                description:
                    _descriptionController.text,
              );
              if(context.mounted){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.grey,
                    content: Text("Blog post created successfully")));
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      "Failed to Create Blog Post",
                    ),
                  ),
                );
              }
            } finally {
              setState(() {
                _isLoading = false;
              });
              Navigator.pop(context);
            }
          },
          child: Text("Add Blog Post"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
      ],
    );
  }
}
