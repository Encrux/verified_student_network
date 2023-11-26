import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../api/api.dart';
import '../model/feed.dart';

class PostCreationView extends StatefulWidget {
  const PostCreationView({super.key});

  @override
  _PostCreationViewState createState() => _PostCreationViewState();
}

class _PostCreationViewState extends State<PostCreationView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              maxLines: 10,
              decoration: const InputDecoration(
                hintText: 'Enter your text here',
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  // Handle the post action here
                  Navigator.pop(context);

                  var post = Post(
                    title: 'title',
                    content: _controller.text,
                    timestamp: Timestamp.now(),
                  );

                  PostDatabase.createPost(post);
                },
                child: const Text('Post'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
