import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/controllers/contact_controller.dart';
import 'package:todo_app/views/screens/note_screen.dart';
import 'package:todo_app/views/screens/todo_screen.dart';

class ContactWidget extends StatefulWidget {
  const ContactWidget({Key? key}) : super(key: key);

  @override
  State<ContactWidget> createState() => _HomePageState();
}

class _HomePageState extends State<ContactWidget> {
  List<Widget> screens = [
    const TodoScreen(),
    const NoteScreen(),
    const ContactWidget(),
    const Center(
      child: Text(
        "To'rtinchi sahifa",
        style: TextStyle(
          fontSize: 40,
          color: Colors.black,
        ),
      ),
    ),
  ];

  // ignore: non_constant_identifier_names
  int _selected_index = 2;

  void onItemTap(int index) {
    setState(() {
      _selected_index = index;
    });
  }

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
              onPressed: () async {
                final response = await showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text("Add Contacts"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Name"),
                            )
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                          FilledButton(
                              onPressed: () {
                                Navigator.pop(context, nameController.text);
                              },
                              child: const Text("Save"))
                        ],
                      );
                    });
                if (response != null) {
                  //! Add new contacts
                  print(response);
                  nameController.clear();
                  await controller.addContacts(response);
                  setState(() {});
                }
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
                    contacts.sort((a, b) => a.fullname
                        .toLowerCase()
                        .compareTo(b.fullname.toLowerCase()));
                    return ListTile(
                      onTap: () async {
                        nameController.text = contacts[index].fullname;
                        final response = await showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: const Text("Edit Contacts"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Name"),
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel")),
                                  FilledButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context, nameController.text);
                                      },
                                      child: const Text("Edit"))
                                ],
                              );
                            });

                        if (response != null) {
                          //! Contact editing
                          controller.editContacts(contacts[index].id, response);
                          setState(() {});
                        }
                      },
                      title: Text(
                        "${index + 1}.${contacts[index].fullname}",
                        style: const TextStyle(fontSize: 30),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            // ! Delete Contacts
                            controller.deleteContacts(contacts[index].id);
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.delete,
                            size: 30,
                          )),
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Person"),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: "Business")
        ],
        currentIndex: _selected_index,
        selectedItemColor: Colors.green,
        onTap: onItemTap,
      ),
    );
  }
}
