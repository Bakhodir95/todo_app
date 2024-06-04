import 'dart:convert';

import 'package:todo_app/models/todo_model.dart';
import 'package:http/http.dart' as http;

class TodoController {
  List<Todo> _list = [];
  List<Todo> get list => [..._list];

  Future<List<Todo>> getTodos() async {
    List<Todo> todos = [];
    final data = await http.get(Uri.parse(
        'https://todonote-912ed-default-rtdb.firebaseio.com/todos.json'));
    Map<String, dynamic> json = jsonDecode(data.body);
    json.forEach((String key, dynamic value) {
      print(value.runtimeType);
      todos.add(Todo.fromJson(value));
      print(value);
    });
    _list = todos;
    return _list;
  }
}
