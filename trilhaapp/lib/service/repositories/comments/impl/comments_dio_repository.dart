// import 'package:dio/dio.dart';
import 'package:trilhaapp/model/comment_model.dart';
import 'package:trilhaapp/service/repositories/comments/comments_repository.dart';
import 'package:trilhaapp/service/repositories/jsonplaceholder_dio.dart';

class CommentsDioRepository implements CommentRepository {
  @override
  Future<List<CommentModel>> getCommentsByPostId(int postId) async {
    var jsonPlaceHolder = JSONPlaceHolder();

    var res = await jsonPlaceHolder.dio.get('/posts/$postId/comments');

    return (res.data as List).map((json) => CommentModel.fromJson(json)).toList();
  }
}
