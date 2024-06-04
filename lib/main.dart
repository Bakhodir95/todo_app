import 'package:flutter/material.dart';
import 'package:todo_app/views/screens/main_screen.dart';

void main(List<String> args) {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
