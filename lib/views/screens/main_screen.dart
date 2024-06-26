import 'package:flutter/material.dart';
import 'package:todo_app/views/screens/note_screen.dart';
import 'package:todo_app/views/screens/todo_screen.dart';
import 'package:todo_app/views/screens/contact_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    TodoScreen(),
    NoteScreen(),
    ContactWidget(),
    NoteScreen(),
  ];

  // ignore: non_constant_identifier_names
  int _selected_index = 2;

  void onItemTap(int index) {
    setState(() {
      _selected_index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      children: [
        TodoScreen(),
        NoteScreen(),
        ContactWidget(),
        Row(
          children: <Widget>[
            NavigationRail(
              selectedIndex: _selected_index,
              onDestinationSelected: onItemTap,
              labelType: NavigationRailLabelType.selected,
              destinations: const [
                NavigationRailDestination(
                    icon: Icon(Icons.home), label: Text("Home")),
                NavigationRailDestination(
                    icon: Icon(Icons.search), label: Text("Search")),
                NavigationRailDestination(
                    icon: Icon(Icons.person), label: Text("Profile")),
                NavigationRailDestination(
                    icon: Icon(Icons.business), label: Text("Business"))
              ],
            ),
            Expanded(child: screens[_selected_index])
          ],
        ),
      ],
    ));
  }
}
