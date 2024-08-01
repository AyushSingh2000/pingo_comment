import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/profile_viewmodel.dart';
import 'comments_bypost.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<void> _fetchPostsFuture;

  @override
  void initState() {
    super.initState();
    _fetchPostsFuture =
        Provider.of<PostViewModel>(context, listen: false).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F9FD),
      body: FutureBuilder(
        future: _fetchPostsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load posts'));
          } else if (snapshot.connectionState == ConnectionState.done) {
            final postViewModel = Provider.of<PostViewModel>(context);
            return ListView.builder(
              itemCount: postViewModel.posts.length,
              itemBuilder: (context, index) {
                final post = postViewModel.posts[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.comment),
                    title: Text('Post ID: ${post.id}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CommentsByPostPage(postId: post.id!),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No posts found'));
          }
        },
      ),
    );
  }
}
