import 'dart:convert';

import 'package:todo_app/models/contact_model.dart';
import 'package:http/http.dart' as http;

class ContactController {
  Future<List<Contact>> getContacts() async {
    Uri url = Uri.parse(
        "https://todonote-912ed-default-rtdb.firebaseio.com/contacts.json");

    final response = await http.get(url);
    final data = jsonDecode(response.body);

    List<Contact> contacts = [];

    if (data != null) {
      data.forEach((key, value) {
        contacts.add(Contact(id: key, fullname: value["fullname"]));
      });
    }
    print(contacts);
    return contacts;
  }

  Future<void> addContacts(String fullname) async {
    Uri url = Uri.parse(
        "https://todonote-912ed-default-rtdb.firebaseio.com/contacts.json");
    final response =
        await http.post(url, body: jsonEncode({"fullname": fullname}));
    final data = jsonDecode(response.body);
    print(data);
  }

  Future<void> editContacts(String id, String fullname) async {
    Uri url = Uri.parse(
        "https://todonote-912ed-default-rtdb.firebaseio.com/contacts/$id.json");
    final respose =
        await http.patch(url, body: jsonEncode({"fullname": fullname}));
  }
}
