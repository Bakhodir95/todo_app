import 'package:flutter/material.dart';

class TodoWidget extends StatefulWidget {
  @override
  State<TodoWidget> createState() => _HomePageState();
}

class _HomePageState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Page"),
        centerTitle: true,
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomLeft,
            width: MediaQuery.of(context).size.width / 5,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.amber),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.edit,
                      size: 40,
                      color: Colors.black,
                    )),
                ElevatedButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.delete,
                      size: 40,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
        )
      ]),
    );
  }
}
