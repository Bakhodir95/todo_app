import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/controllers/contact_controller.dart';

class ContactWidget extends StatefulWidget {
  const ContactWidget({Key? key}) : super(key: key);

  @override
  State<ContactWidget> createState() => _HomePageState();
}

class _HomePageState extends State<ContactWidget> {
  ContactController controller = ContactController();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contact Page",
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text("Add Contacts"),
                        content: Column(
                          children: [
                            TextField(
                              controller: nameController,
                              decoration:
                                  InputDecoration(border: OutlineInputBorder()),
                            )
                          ],
                        ),
                      );
                    });
              },
              icon: const Icon(
                Icons.add,
                size: 40,
              ))
        ],
      ),
      body: FutureBuilder(
        future: controller.getContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final contacts = snapshot.data;
          return contacts == null || contacts.isEmpty
              ? const Center(
                  child: Text("No contacts yet!"),
                )
              : ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      title: Text(
                        "${index + 1}.${contacts[index].name}",
                        style: const TextStyle(fontSize: 30),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
