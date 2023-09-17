import 'package:flutter/material.dart';
import 'package:trilhaapp/model/post_model.dart';
import 'package:trilhaapp/pages/comments_page.dart';
import 'package:trilhaapp/service/repositories/http/posts_repository.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  var postsRepository = PostsHTTPRepository();
  var posts = <PostModel>[];

  loadData() async {
    posts = await postsRepository.fetchPosts();
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Posts")),
        body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (_, index) {
            var post = posts[index];
            return Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CommentsPage(postID: post.id!),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title!,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          post.body!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
