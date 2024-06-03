import 'dart:convert';

import 'package:todo_app/models/todo_model.dart';
import 'package:http/http.dart' as http;

class TodoController {
  final List<Todo> _list = [];
  List<Todo> get list => [..._list];

  Future<void> getTodos() async {
    final data = await http.get(Uri.parse(
        'https://todonote-912ed-default-rtdb.firebaseio.com/todos.json'));
    Map<String, dynamic> json = jsonDecode(data.body);
    json.forEach((String key, dynamic value) {
      _list.add(Todo.fromJson(value));
    });
  }
}
