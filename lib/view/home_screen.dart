import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/comment_viewmodel.dart';
import '../widgets/comment_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<void> _fetchCommentsFuture;

  @override
  void initState() {
    super.initState();
    _fetchCommentsFuture =
        Provider.of<CommentViewModel>(context, listen: false).fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0C54BE),
        title: Text(
          'Comments',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        color: Color(0xFFF5F9FD),
        child: FutureBuilder(
          future: _fetchCommentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("FutureBuilder: waiting");
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print("FutureBuilder: error - ${snapshot.error}");
              return Center(child: Text('Failed to load comments'));
            } else if (snapshot.connectionState == ConnectionState.done) {
              print("FutureBuilder: done");
              final commentViewModel = Provider.of<CommentViewModel>(context);
              return ListView.builder(
                itemCount: commentViewModel.comments.length,
                itemBuilder: (context, index) {
                  return CommentTile(comment: commentViewModel.comments[index]);
                },
              );
            } else {
              return Center(child: Text('No comments found'));
            }
          },
        ),
      ),
    );
  }
}
