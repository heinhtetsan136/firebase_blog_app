import 'package:firebase_blog_app/data/blog_database.dart';
import 'package:flutter/material.dart';

import '../../data/blog_post_model.dart';
import 'edit_blog_Post.dart';

class BloPostItem extends StatefulWidget {
  final String docId;
  const BloPostItem({
    super.key,
    required this.blogDoc,
    required this.docId,
  });

  final BlogPostModel blogDoc;

  @override
  State<BloPostItem> createState() =>
      _BloPostItemState();
}

class _BloPostItemState
    extends State<BloPostItem> {
  final BlogDatabase blogDatabase =
      BlogDatabase();
  @override
  Widget build(BuildContext context) {
    final BlogPostModel model = widget.blogDoc;
    final MenuController menuController =
        MenuController();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person, size: 30),
                  SizedBox(width: 8),
                  Text(
                    "Mg Mg",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  MenuAnchor(
                    controller: menuController,
                    menuChildren: [
                      MenuItemButton(
                        onPressed: () {
                          _editBlogPost(
                            id: widget.docId,
                            model: model,
                          );
                          // Handle edit action
                        },
                        child: Text('Edit'),
                      ),
                      MenuItemButton(
                        onPressed: () {
                          _delete(
                            id: widget.docId,
                          );
                          // Handle delete action
                        },
                        child: Text('Delete'),
                      ),
                    ],
                    builder: (_, __, ___) {
                      return IconButton(
                        onPressed: () {
                          menuController.open();
                        },
                        icon: Icon(
                          Icons.more_vert,
                        ),
                      );
                    },
                  ),
                ],
              ),
              Divider(),
              Center(
                child: Text(
                  "${widget.blogDoc.title}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "${widget.blogDoc.description}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _delete({required String id}) async {
    try {
      await blogDatabase.deletePost(id);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            content: Text("Successfully Deleted"),
            backgroundColor: Colors.grey,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            content: Text("Failed to Delete"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _editBlogPost({
    required String id,
    required BlogPostModel model,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditBlogPost(id: id, model: model);
      },
    );
  }
}
