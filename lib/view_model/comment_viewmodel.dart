import 'package:flutter/material.dart';

import '../models/comment_model.dart';
import '../services/api_service.dart';

class CommentViewModel extends ChangeNotifier {
  List<CommentModel> _comments = [];
  bool _isLoading = false;
  int _page = 1;
  final int _limit = 20; // Number of comments per page

  List<CommentModel> get comments => _comments;

  Future<void> fetchComments({bool loadMore = false}) async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      final newComments = await ApiService.fetchComments(_page, _limit);
      if (loadMore) {
        _comments.addAll(newComments);
      } else {
        _comments = newComments;
      }
      _page++;
    } catch (e) {
      print('Error fetching comments: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}