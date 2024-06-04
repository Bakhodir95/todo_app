import 'package:flutter/material.dart';
import 'package:todo_app/views/widgets/note_widget.dart';
import 'package:todo_app/views/widgets/todo_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    const Center(
      child: Text("Bosh sahifa"),
    ),
    const Center(
      child: Text("Ikkinchi sahifa"),
    ),
    const Center(
      child: Text("Uchinchi sahifa"),
    ),
    const Center(
      child: Text("Uchinchi sahifa"),
    ),
  ];

  // ignore: non_constant_identifier_names
  int _selected_index = 0;

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
        TodoWidget(),
        NoteWidget(),
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
