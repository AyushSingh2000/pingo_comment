import 'package:flutter/material.dart';

import '../models/postModel.dart';
import '../services/api_service.dart';

class PostViewModel extends ChangeNotifier {
  List<PostModel> _posts = [];

  List<PostModel> get posts => _posts;

  Future<void> fetchPosts() async {
    try {
      final fetchedPosts = await ApiService.fetchPosts();
      _posts = fetchedPosts;
      notifyListeners();
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }
}
