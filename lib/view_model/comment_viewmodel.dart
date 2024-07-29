import 'package:flutter/material.dart';

import '../models/comment_model.dart';
import '../services/api_service.dart';

class CommentViewModel extends ChangeNotifier {
  List<CommentModel> _comments = [];
  List<CommentModel> get comments => _comments;

  Future<void> fetchComments() async {
    try {
      print("Fetching comments...");
      _comments = await ApiService().fetchComments();
      print("Fetched comments successfully.");
      notifyListeners();
    } catch (e) {
      print("Error fetching comments: $e");
    }
  }
}