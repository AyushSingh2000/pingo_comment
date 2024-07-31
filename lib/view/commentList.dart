import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/comment_viewmodel.dart';
import '../widgets/comment_tile.dart';

class CommentsList extends StatefulWidget {
  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  late Future<void> _fetchCommentsFuture;
  late ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _fetchCommentsFuture =
        Provider.of<CommentViewModel>(context, listen: false).fetchComments();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });
      Provider.of<CommentViewModel>(context, listen: false)
          .fetchComments(loadMore: true)
          .then((_) {
        setState(() {
          _isLoadingMore = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: commentViewModel.comments.length,
                  itemBuilder: (context, index) {
                    return CommentTile(
                        comment: commentViewModel.comments[index]);
                  },
                ),
              ),
              if (_isLoadingMore)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        } else {
          return Center(child: Text('No comments found'));
        }
      },
    );
  }
}
