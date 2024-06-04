import 'dart:convert';

import 'package:todo_app/models/note_model.dart';
import 'package:http/http.dart' as http;

class NoteController {
  List<Note> _list = [];
  List<Note> get list => [..._list];

  Future<List<Note>> getNotes() async {
    List<Note> notes = [];
    final data = await http.get(Uri.parse(
        'https://todonote-912ed-default-rtdb.firebaseio.com/notes.json'));
    Map<String, dynamic> json = jsonDecode(data.body);
    json.forEach((String key, dynamic value) {
      _list.add(Note.fromJson(value));
      print(value.runtimeType);
      notes.add(Note.fromJson(value));
      print(value);
    });
    _list = notes;
    return _list;
  }
}
