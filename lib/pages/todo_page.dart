import 'package:flutter/material.dart';
import 'package:todoapp/util/dialog_box.dart';
import 'package:todoapp/util/todo_tile.dart';

// Global map to store tasks per date (formatted as "dd.mm.yyyy")
Map<String, List> tasksByDate = {};

// Helper function to format the date key
String formatDateKey(DateTime date) =>
    "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";

class TodoPage extends StatefulWidget {
  final DateTime selectedDate;
  const TodoPage({super.key, required this.selectedDate});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _controller = TextEditingController();
  late List todoList;
  late String dateKey;

  @override
  void initState() {
    super.initState();
    dateKey = formatDateKey(widget.selectedDate);
    // If no tasks exist for this date, initialize an empty list.
    if (!tasksByDate.containsKey(dateKey)) {
      tasksByDate[dateKey] = [];
    }
    todoList = tasksByDate[dateKey]!;
  }

  // Checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  // Save new task
  void saveNewTask() {
    setState(() {
      todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  // Create new task dialog
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // Delete task
  void deleteTask(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // dateKey is used to display the date formatted as "dd.mm.yyyy"
    return Scaffold(
      backgroundColor: Colors.pinkAccent[100],
      appBar: AppBar(
        title: Text(dateKey),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 201, 63, 125),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: todoList[index][0],
            taskCompleted: todoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
