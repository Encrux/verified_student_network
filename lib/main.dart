import 'package:verified_student_network/presentation/character_list_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Infinite Scroll Pagination Sample',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: CharacterListScreen(),
      );
}
