import 'package:flutter/material.dart';
import 'package:trilhaapp/model/comment_model.dart';
import 'package:trilhaapp/service/repositories/http/comments_repository.dart';

class CommentsPage extends StatefulWidget {
  final int postID;
  const CommentsPage({super.key, required this.postID});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  var commentsRepository = CommentsHTTPRepository();
  var comments = <CommentModel>[];

  loadData() async {
    comments = await commentsRepository.getComments(widget.postID);
    setState(() {});
  }

  @override
  initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Comentários")),
        body: Container(
          margin: const EdgeInsets.all(8.0),
          child: comments.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (_, index) {
                    var comment = comments[index];
                    return Card(
                        child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(comment.name!.substring(0, 6)),
                              Text(comment.email!),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(comment.body!),
                        ],
                      ),
                    ));
                  }),
        ),
      ),
    );
  }
}
