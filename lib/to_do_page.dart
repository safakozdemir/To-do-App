import 'package:flutter/material.dart';
import 'package:mytodos/to_do_tile.dart';

import 'new_task_dialog.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _controller = TextEditingController();

  List todoList = [
    ['Make Tutorial', false],
    ['Make Tutoriallllll', false]
  ];

  void checkBoxStateChanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  void saveTask() {
    setState(() {
      todoList.add([_controller.text, false]);
      _controller.clear();
      Navigator.of(context).pop();
    });
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return TaskDialogBox(
          controller: _controller,
          onSave: saveTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('TO DO', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.yellow[400],
          elevation: 0,
        ),
        backgroundColor: Colors.yellow[200],
        body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: todoList[index][0],
              checked: todoList[index][1],
              onChanged: (value) => checkBoxStateChanged(value, index),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.redAccent,
          backgroundColor: Colors.yellow[600],
          onPressed: createTask,
          child: const Icon(Icons.add),
        ));
  }
}
