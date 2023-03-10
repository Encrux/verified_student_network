import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:verified_student_network/presentation/post.dart';
import 'package:verified_student_network/presentation/post_list.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostWidget>>(
      future: Future.delayed(const Duration(seconds: 5), () => parseDbgJson()),
      builder: (context, snapshot) {
          return MaterialApp(
            title: 'Infinite Scroll Pagination Sample',
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            home: snapshot.hasData ? PostListScreen(
              initialPosts: snapshot.data!,
            ) : const Center(
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator()
              ),
            ),
          );
      },
    );
  }

  Future<List<PostWidget>> parseDbgJson() async {
    final json = await rootBundle.loadString('assets/sample.json');
    final jsonArray = jsonDecode(json) as List<dynamic>;
    return jsonArray.map((jsonObject) => PostWidget(
      title: jsonObject['title'],
      content: jsonObject['content'],
    )).toList();
  }


}
