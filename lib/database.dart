import 'package:hive_flutter/hive_flutter.dart';

class TodoDataBase {
  List todoList = [];
  final _mybox = Hive.box('mybox');

  void createInitialTile() {
    todoList = [
      ['Add Your Task', false],
      ['Drink a Glass of  Water', false]
    ];
  }

  void loadDataBase() {
    todoList = _mybox.get('TODOLIST');
  }

  void updateDataBase() {
    _mybox.put('TODOLIST', todoList);
  }
}
