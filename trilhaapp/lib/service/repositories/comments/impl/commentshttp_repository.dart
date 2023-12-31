import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trilhaapp/model/comment_model.dart';
import 'package:trilhaapp/service/repositories/comments/comments_repository.dart';

class CommentsHTTPRepository implements CommentRepository {
  @override
  Future<List<CommentModel>> getCommentsByPostId(int commentID) async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$commentID/comments'));
    if (response.statusCode == 200) {
      var commentsJson = json.decode(response.body);
      return (commentsJson as List).map((json) => CommentModel.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching comments');
    }
  }
}