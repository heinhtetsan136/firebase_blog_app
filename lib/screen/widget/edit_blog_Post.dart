import 'package:firebase_blog_app/data/blog_database.dart';
import 'package:firebase_blog_app/data/blog_post_model.dart';
import 'package:flutter/material.dart';

class EditBlogPost extends StatefulWidget {
  final String  id;
  final BlogPostModel model;
  const EditBlogPost({
    super.key,
    required this.id,
   required this.model
  });

  @override
  State<EditBlogPost> createState() =>
      _EditBlogPostState();
}

class _EditBlogPostState
    extends State<EditBlogPost> {
  @override
  void initState() {
    // TODO: implement initState
    _titleController.text = widget.model.title ?? '';
    _descriptionController.text = widget.model.description ?? '';
    super.initState();
  }

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
              await blogDatabase.updatePost(
                docId: widget.id,
                model: widget.model.copyWith(
                  title: _titleController.text
                      .trim(),
                  description:
                      _descriptionController.text
                          .trim(),
                  updatedAt: DateTime.now().microsecondsSinceEpoch

                ),
              );
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.grey,
                    content: Text(
                      "Blog post updated successfully",
                    ),
                  ),
                );
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      "Failed to updated Blog Post",
                    ),
                  ),
                );
              }
            } finally {
              setState(() {
                _isLoading = false;
              });
              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          },
          child: Text("Updated Blog Post"),
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
