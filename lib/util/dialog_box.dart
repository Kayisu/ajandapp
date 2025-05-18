import 'package:flutter/material.dart';
import 'package:todoapp/util/my_button.dart';

class DialogBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 196, 192, 253),
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Add a new task',
                border: OutlineInputBorder(),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: "save", onPressed: onSave),
                const SizedBox(width: 8),
                MyButton(text: "cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
