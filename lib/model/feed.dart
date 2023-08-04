import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Post {
  final String title;
  final String content;

  Post({
    required this.title,
    required this.content,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'] as String,
      content: json['body'] as String,
    );
  }
}

class Feed {
  final databaseRef = FirebaseDatabase.instance.ref();

  List<Post> parsePosts(DataSnapshot snapshot) {
    final posts = <Post>[];
    final json = snapshot.value as Map<dynamic, dynamic>;

    json.forEach((key, value) {
      final post = Post.fromJson(value);
      posts.add(post);
    });

    return posts;
  }

  Future<List<Post>> getPosts() async {
    var posts = <Post>[];

    //retrieve data from firebase correctly
    await databaseRef.once().then((event) {
      posts = parsePosts(event.snapshot);
    });
    return posts;
  }
}