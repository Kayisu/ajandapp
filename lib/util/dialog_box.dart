import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget { // Yeni görev eklemek için kullanılan Dialog
  final TextEditingController controller; // TextField için kullanılan controller
  final VoidCallback onSave; // Görevi kaydetmek için kullanılan callback
  final VoidCallback onCancel; // Görevi iptal etmek için kullanılan callback

  const DialogBox({ 
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });
  

  @override
  Widget build(BuildContext context) {

    final ButtonStyle style = ElevatedButton.styleFrom( //Buton stili
      backgroundColor: const Color.fromARGB(255, 115, 64, 201),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(), 
    );

    return AlertDialog( // AlertDialog ile yeni görev ekleme arayüzü 
      backgroundColor: const Color.fromARGB(255, 196, 192, 253),
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
          children: [
            TextField( // Yeni görev için TextField
              controller: controller, 
              decoration: InputDecoration( 
                hintText: 'Yeni bir görev ekle',
                border: OutlineInputBorder(),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: onSave, style: style, child: const Text("Kaydet"),), // Kaydetme butonu
                const SizedBox(width: 8),
                ElevatedButton(onPressed: onCancel, style: style, child: const Text("İptal")), // İptal etme butonu
              ],
            ),
          ],
        ),
      ),
    );
  }
}
