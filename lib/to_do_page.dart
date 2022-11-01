import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mytodos/database.dart';
import 'package:mytodos/to_do_tile.dart';

import 'new_task_dialog.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _mybox = Hive.box('mybox');

  final _controller = TextEditingController();

  TodoDataBase tdDb = TodoDataBase();

  @override
  void initState() {
    if (_mybox.get('TODOLIST') == null) {
      tdDb.createInitialTile();
    } else {
      tdDb.loadDataBase();
    }
    super.initState();
  }

  void checkBoxStateChanged(bool? value, int index) {
    setState(() {
      tdDb.todoList[index][1] = !tdDb.todoList[index][1];
      tdDb.updateDataBase();
    });
  }

  void saveTask() {
    setState(() {
      tdDb.todoList.add([_controller.text, false]);
      _controller.clear();
      Navigator.of(context).pop();
      tdDb.updateDataBase();
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

  void deleteTask(int index) {
    setState(() {
      tdDb.todoList.removeAt(index);
    });
    tdDb.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF701ebd),
              Color(0xFF873bcc),
              Color(0xFFfe4a97),
              Color(0xFFe17763),
              Color(0xFF68998c),
            ], begin: Alignment.topRight, end: Alignment.bottomLeft),
          ),
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                title: Text('MY TO DO!',
                    style: TextStyle(color: Colors.black, fontSize: 25)),
                backgroundColor: Colors.transparent,
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                    height: 20,
                    child: Center(
                        child: Text(
                      'You have ${tdDb.todoList.length} tasks',
                      style: const TextStyle(fontSize: 22),
                    ))),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ToDoTile(
                        taskName: tdDb.todoList[index][0],
                        checked: tdDb.todoList[index][1],
                        onChanged: (value) =>
                            checkBoxStateChanged(value, index),
                        deleteFunction: (context) => deleteTask(index));
                  },
                  childCount: tdDb.todoList.length,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          mini: true,
          foregroundColor: Colors.redAccent,
          backgroundColor: Colors.purple[500],
          onPressed: createTask,
          child: const Icon(Icons.add),
        ));
  }
}
