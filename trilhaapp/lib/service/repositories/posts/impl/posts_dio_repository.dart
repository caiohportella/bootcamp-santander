import 'package:trilhaapp/model/post_model.dart';
import 'package:trilhaapp/service/repositories/jsonplaceholder_dio.dart';
import 'package:trilhaapp/service/repositories/posts/posts_repository.dart';

// import 'package:dio/dio.dart';

class PostsDIORepository implements PostsRepository {
  @override
  Future<List<PostModel>> fetchPosts() async {
    var jsonPlaceHolder = JSONPlaceHolder();
    var res = await jsonPlaceHolder.dio.get("/posts");
    if (res.statusCode == 200) {
      return (res.data as List).map((e) => PostModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load post');
    }
  }
}
