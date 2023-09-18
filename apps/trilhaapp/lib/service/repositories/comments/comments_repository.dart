import 'package:trilhaapp/model/comment_model.dart';

abstract class CommentRepository {
  Future<List<CommentModel>> getCommentsByPostId(int postId);
}