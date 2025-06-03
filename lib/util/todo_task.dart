import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTask extends StatelessWidget { // Tek bir görev için kullanılan widget
  final String taskName; // Görev adı
  final bool taskCompleted; // Görev tamamlandı mı?
  final Function(bool?)? onChanged; // Görev tamamlanma durumunu değiştirmek için kullanılan callback
  final Function(BuildContext)? deleteFunction; // Görevi silmek için kullanılan callback

  const ToDoTask({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable( // Slidable widget ile görevler sağa kaydırılarak silinebilir
        endActionPane: ActionPane( // Slidable için sağa kaydırma hareketi
          motion: StretchMotion(), // Kaydırma hareketi
          children: [ 
            SlidableAction( // SlidableAction ile sağa kaydırıldığında gösterilecek buton
              onPressed: deleteFunction, // Basıldığında deleteFunction çağrılır
              icon: Icons.delete, // Silme ikonu
              backgroundColor: Colors.red,
            ),
          ],
        ),
        child: Container( // Görev container'ı
          padding: EdgeInsets.all(24), 
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 115, 64, 201),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Checkbox( // Görev tamamlandı mı kontrol etmek için kullanılan Checkbox
                value: taskCompleted, // Görev tamamlandı mı?
                onChanged: onChanged, // Checkbox değiştiğinde onChanged çağrılır
                activeColor: const Color.fromARGB(255, 38, 17, 95),
              ),
              Text( // Görev adı ve stillemeleri
                taskName,
                style: TextStyle(
                  decoration:
                      taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
