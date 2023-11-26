import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Post {
  final String title;
  final String content;
  final Timestamp timestamp;

  Post({
    required this.title,
    required this.content,
    required this.timestamp,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'] as String,
      content: json['body'] as String,
      timestamp: json['timestamp'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': content,
    };
  }
}

class ContentFeed {
  static final ContentFeed _instance = ContentFeed._internal();

  factory ContentFeed() => _instance;

  ContentFeed._internal();

  final _databaseRef = FirebaseDatabase.instance.ref();

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
    await _databaseRef.once().then((event) {
      posts = parsePosts(event.snapshot);
    });
    return posts;
  }

  Future<void> createPost(Post post) async {
    await _databaseRef.push().set(post.toJson());
  }
}