import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/comment_model.dart';

class ApiService {
  final String commentsUrl = 'https://jsonplaceholder.typicode.com/comments';

  Future<List<CommentModel>> fetchComments() async {
    try {
      print("Making API request...");
      final response = await http.get(Uri.parse(commentsUrl));

      if (response.statusCode == 200) {
        print("API request successful.");
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => CommentModel.fromJson(json)).toList();
      } else {
        print(
            "Failed to load comments with status code: ${response.statusCode}");
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      print("Error fetching comments from API: $e");
      throw e;
    }
  }
}
