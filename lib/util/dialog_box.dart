import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
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

    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 115, 64, 201),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(),
    );


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
                hintText: 'Yeni bir görev ekle',
                border: OutlineInputBorder(),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: onSave, style: style, child: const Text("Kaydet"),),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: onCancel, style: style, child: const Text("İptal")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
