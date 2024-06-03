import 'package:flutter/material.dart';
import 'package:todo_app/controllers/todo_controller.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TodoController todoController = TodoController();

void editTodo(Todo todo){

}


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: todoController.getTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()),)
          }
          if (!snapshot.hasData) {
              return const Center(
                child: Text("There is no product, please add product first!"),
              );
         }
         final todos = snapshot.data;
         return todos == null
                ? const Center(
                    child: Text("Mahsulotlar mavjud emas, iltimos qo'shing"),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: todos.length,
                    itemBuilder: (ctx, index) {
                      final todo = todos[index];
                      return TodoItem(
                        todo: todo,
                        onEdit: () {
                          editTodo(todo);
                        },
                        onDelete: () {
                          deleteTodo(todo);
                        },
                      );
                    },
                  );
          // return ListView.builder(
          //     itemCount: todoController.list.length,
          //     itemBuilder: (context, index) {
          //       return Card(child: ListTile(),)
          //     });
        });
  }
}
