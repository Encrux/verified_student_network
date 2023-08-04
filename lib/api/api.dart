import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/feed.dart';

class PostDatabase {

  static Future<List<Post>> getPosts() async {
    CollectionReference postsRef = FirebaseFirestore.instance.collection('posts');
    QuerySnapshot querySnapshot = await postsRef.get();

    FirebaseFirestore.instance.collection('posts').snapshots().first.then((value) => print(value.docs));

    List<Post> posts =  [];
    for (var doc in querySnapshot.docs) {
      posts.add(Post(
        title: doc['title'],
        content: doc['content'],
      ));
    }
    return posts;
  }
}