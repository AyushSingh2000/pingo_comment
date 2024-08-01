import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/comment_viewmodel.dart';
import '../widgets/comment_tile.dart';

class CommentsByPostPage extends StatelessWidget {
  final int postId;

  CommentsByPostPage({required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments for Post ID: $postId'),
      ),
      body: FutureBuilder(
        future: Provider.of<CommentViewModel>(context, listen: false)
            .fetchCommentsByPostId(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load comments'));
          } else if (snapshot.connectionState == ConnectionState.done) {
            final commentViewModel = Provider.of<CommentViewModel>(context);
            final comments = commentViewModel.comments
                .where((comment) => comment.postId == postId)
                .toList();
            return ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return CommentTile(comment: comments[index]);
              },
            );
          } else {
            return Center(child: Text('No comments found'));
          }
        },
      ),
    );
  }
}
