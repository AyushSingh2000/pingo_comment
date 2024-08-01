import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/comment_model.dart';
import '../models/postModel.dart';

// import '../models/comment_model.dart';
//
// class ApiService {
//   static Future<List<CommentModel>> fetchComments(int page, int limit) async {
//     try {
//       final response = await http.get(
//         Uri.parse(
//             'https://jsonplaceholder.typicode.com/comments?_page=$page&_limit=$limit'),
//       );
//
//       if (response.statusCode == 200) {
//         Iterable jsonResponse = json.decode(response.body);
//         return List<CommentModel>.from(
//             jsonResponse.map((model) => CommentModel.fromJson(model)));
//       } else {
//         throw Exception('Failed to load comments: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       print('Error fetching comments: $e');
//       throw Exception('Failed to load comments');
//     }
//   }
// }

class ApiService {
  static Future<List<CommentModel>> fetchComments(int page, int limit) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://jsonplaceholder.typicode.com/comments?_page=$page&_limit=$limit'),
      );

      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body);
        return List<CommentModel>.from(
            jsonResponse.map((model) => CommentModel.fromJson(model)));
      } else {
        throw Exception('Failed to load comments: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching comments: $e');
      throw Exception('Failed to load comments');
    }
  }

  static Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body);
        return List<PostModel>.from(
            jsonResponse.map((model) => PostModel.fromJson(model)));
      } else {
        throw Exception('Failed to load posts: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching posts: $e');
      throw Exception('Failed to load posts');
    }
  }

  static Future<List<CommentModel>> fetchCommentsByPostId(int postId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://jsonplaceholder.typicode.com/comments?postId=$postId'),
      );

      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body);
        return List<CommentModel>.from(
            jsonResponse.map((model) => CommentModel.fromJson(model)));
      } else {
        throw Exception('Failed to load comments: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching comments: $e');
      throw Exception('Failed to load comments');
    }
  }
}
