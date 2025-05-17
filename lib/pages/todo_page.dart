import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/utils/todo_tile.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

DateTime now = DateTime.now();
String formattedDate1 = DateFormat('dd/MM').format(now);
String formattedDate2 = DateFormat('yyyy').format(now);

class _TodoPageState extends State<TodoPage> {
  List toDoList = [
    ["Bir roket yapmak", false],
    ["Mumyalarla gürşemek", false],
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = value;
    });
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const SizedBox(width: 10),
                Text(
                  formattedDate1,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  formattedDate2,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(
                      Icons.wb_sunny,
                      size: 20,
                      color: Colors.yellowAccent,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Derece",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Text(
                  "Şehir Adı",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
          );
        },
      ),
    );
    return scaffold;
  }
}
