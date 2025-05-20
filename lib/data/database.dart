import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  // Reference the box
  final _myBox = Hive.box('myBox');

  void createInitialData() {
    toDoList = [
      ["make tutorial", false],
      ["blabla", false],
      ["lalalalla", false],
      ["", false],
      ["", false],
    ];
  }

  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
