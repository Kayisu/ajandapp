import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/util/dialog_box.dart';
import 'package:todoapp/util/todo_tile.dart';

// Global map to store tasks per date
Map<String, List> tasksByDate = {};

String formatDateKey(DateTime date) =>
    "${date.day.toString().padLeft(2,'0')}.${date.month.toString().padLeft(2,'0')}.${date.year}";

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
  bool _isLoading = true; // add loading flag

  @override
  void initState() {
    super.initState();
    dateKey = formatDateKey(widget.selectedDate); // initialize dateKey right away
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonStr = prefs.getString('tasksByDate');
    if (jsonStr != null) {
      final Map<String, dynamic> decoded = jsonDecode(jsonStr);
      tasksByDate = decoded.map((k, v) => MapEntry(k, List.from(v)));
    }
    dateKey = formatDateKey(widget.selectedDate);
    tasksByDate.putIfAbsent(dateKey, () => []);
    setState(() {
      todoList = tasksByDate[dateKey]!;
      _isLoading = false; // tasks loaded
    });
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tasksByDate', jsonEncode(tasksByDate));
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = value ?? false;
    });
    _saveTasks();
  }

  // Save new task
  void saveNewTask() {
    setState(() {
      todoList.add([_controller.text, false]);
      _controller.clear();
    });
    _saveTasks();
    Navigator.of(context).pop();
  }

  // Create new task dialog
  void createNewTask() {
    showDialog(
      context: context,
      builder: (_) => DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  // Delete task
  void deleteTask(int index) {
    setState(() {
      todoList.removeAt(index);
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    // dateKey is used to display the date formatted as "dd.mm.yyyy"
    return Scaffold(
      backgroundColor: const Color.fromARGB(255,196,174,233),
      appBar: AppBar(
        title: Text(dateKey),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (_, i) => ToDoTile(
                taskName: todoList[i][0],
                taskCompleted: todoList[i][1],
                onChanged: (v) => checkBoxChanged(v, i),
                deleteFunction: (_) => deleteTask(i),
              ),
            ),
    );
  }
}