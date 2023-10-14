import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trilhaapp/model/post_model.dart';
import 'package:trilhaapp/service/repositories/posts/posts_repository.dart';

class PostsHTTPRepository implements PostsRepository {
  @override
  Future<List<PostModel>> fetchPosts() async {
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      var postList = jsonDecode(response.body);
      return (postList as List).map((e) => PostModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load post');
    }
  }
}
