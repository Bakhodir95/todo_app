import 'package:flutter/material.dart';
import 'package:todo_app/controllers/contact_controller.dart';

class ContactWidget extends StatefulWidget {
  const ContactWidget({Key? key}) : super(key: key);

  @override
  State<ContactWidget> createState() => _HomePageState();
}

class _HomePageState extends State<ContactWidget> {
  ContactController controller = ContactController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Page"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
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
                      title: Text("${index + 1}.${contacts[index].name}"),
                    );
                  },
                );
        },
      ),
    );
  }
}
