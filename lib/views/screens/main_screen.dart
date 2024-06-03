import 'package:flutter/material.dart';
import 'package:todo_app/views/widgets/note_widget.dart';
import 'package:todo_app/views/widgets/todo_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      children: [
        TodoWidget(),
        NoteWidget(),
      ],
    ));
  }
}
