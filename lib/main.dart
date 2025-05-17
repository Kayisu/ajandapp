import 'package:flutter/material.dart';
import 'package:todoapp/pages/todo_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoPage(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
