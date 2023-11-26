import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:verified_student_network/presentation/bottom_navigation_widget.dart';
import 'package:verified_student_network/presentation/create_post.dart';
import 'package:verified_student_network/presentation/post_widget.dart';
import 'package:verified_student_network/presentation/post_list_widget.dart';
import 'package:flutter/services.dart';

import 'api/api.dart';
import 'api/api_test.dart';
import 'model/feed.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  TestApi.write();
  PostDatabase.getPosts().then((value) => print(value));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostWidget>>(
      //initialize feed
      future: Future.delayed(const Duration(seconds: 1), () => parseDbgJson()),
      builder: (context, snapshot) {
          return MaterialApp(
            title: 'Infinite Scroll Pagination Sample',
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            home: Scaffold(
                body: _feed(snapshot),
                bottomNavigationBar: const BottomNavigation()
            ),
            routes: {
              '/new_post': (context) => const PostCreationView(),
            }
          );
      },
    );
  }

  Widget _feed(AsyncSnapshot<List<PostWidget>> snapshot) {
    return snapshot.hasData ? PostListScreen(
            initialPosts: snapshot.data!,
          ) : const Center(
            child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator()
            ),
          );
  }

  Future<List<PostWidget>> parseDbgJson() async {
    final json = await rootBundle.loadString('assets/sample.json');
    final jsonArray = jsonDecode(json)['posts'] as List<dynamic>;
    return jsonArray.map((jsonObject) => PostWidget(
      post: Post(
        title: jsonObject['title'],
        content: jsonObject['content'],
        timestamp: Timestamp.now(),
        )
    )).toList();
  }
}