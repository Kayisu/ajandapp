import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ajandapp/util/dialog_box.dart';
import 'package:ajandapp/util/todo_task.dart';

// Her tarih için görevleri saklayan global harita
Map<String, List> tasksByDate = {};

String formatDateKey(DateTime date) => //Tarihi formatlamak için formatDateKey fonksiyonu
    "${date.day.toString().padLeft(2,'0')}.${date.month.toString().padLeft(2,'0')}.${date.year}"; // tarihi dd.mm.yyyy formatında döndürür 

class TodoPage extends StatefulWidget { //Seçili tarihin görevlerini gösteren TodoPage widget'ı
  final DateTime selectedDate;
  const TodoPage({super.key, required this.selectedDate}); 

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _controller = TextEditingController(); // TextField için kullanılan controller (yeni görev eklemek için)
  late List todoList; // Günlük görevlerin listesi
  late String dateKey; //tarih
  bool _isLoading = true; // Görevler yüklenirken gösterilen yükleniyor durumu

  @override
  void initState() {
    super.initState();
    dateKey = formatDateKey(widget.selectedDate); // formatDateKey fonksiyonunu kullanarak seçili tarihi formatlıyoruz
    _loadTasks(); // _loadTasks fonksiyonunu çağırarak görevleri yüklüyoruz
  }

  Future<void> _loadTasks() async { // SharedPreferences'dan görevleri yükleyen asenkron metot
    final prefs = await SharedPreferences.getInstance(); // SharedPreferences instance'ını alıyoruz
    final String? jsonStr = prefs.getString('tasksByDate'); // Tüm tarihlerin görevlerini içeren JSON string'i alıyoruz
    if (jsonStr != null) { //jsonStr null değilse, yani daha önce kaydedilmiş görevler varsa
      final Map<String, dynamic> decoded = jsonDecode(jsonStr); // JSON string'i Map'e çeviriyoruz
      tasksByDate = decoded.map((k, v) => MapEntry(k, List.from(v))); // JSON'dan gelen veriyi uygun formata dönüştürüyoruz
    }
    dateKey = formatDateKey(widget.selectedDate); // Seçili tarihin formatlanmış halini dateKey değişkenine atıyoruz
    tasksByDate.putIfAbsent(dateKey, () => []); // Eğer o tarih için liste yoksa boş bir liste oluşturuyoruz
    setState(() {
      todoList = tasksByDate[dateKey]!; // O günün görevlerini todoList'e atıyoruz
      _isLoading = false; 
    });
  }

  Future<void> _saveTasks() async { // Görevleri SharedPreferences'a kaydeden asenkron metot
    final prefs = await SharedPreferences.getInstance(); // SharedPreferences instance'ını alıyoruz
    await prefs.setString('tasksByDate', jsonEncode(tasksByDate)); // Tüm tasksByDate haritasını JSON'a çevirip kaydediyoruz
  }

  void checkBoxChanged(bool? value, int index) { // Görev tamamlandı işaretlemesi için kullanılan metot
    setState(() {
      todoList[index][1] = value ?? false; // Görevin tamamlanma durumunu güncelliyoruz
    });
    _saveTasks(); // Değişiklikleri kaydediyoruz
  }

  // Yeni görevi kaydetme
  void saveNewTask() {
    setState(() {
      todoList.add([_controller.text, false]); // Yeni görevi listeye ekliyoruz (varsayılan olarak tamamlanmamış olarak geliyor)
      _controller.clear(); // Text controller'ı temizliyoruz
    });
    _saveTasks(); // Yeni eklenen görevi kaydediyoruz
    Navigator.of(context).pop(); // DialogBox ile açılan arayüzü kapatıyoruz
  }

  // Yeni görev ekleme
  void createNewTask() {
    showDialog(
      context: context,
      builder: (_) => DialogBox( // Oluşturduğumuz DialogBox ile yeni görev ekleme arayüzü
        controller: _controller, 
        onSave: saveNewTask, // Kaydet butonuna basıldığında saveNewTask metodu çağrılır
        onCancel: () => Navigator.of(context).pop(), // İptal butonuna basıldığında DialogBox arayüzü kapanır
      ),
    );
  }

  // Görevi silme
  void deleteTask(int index) {
    setState(() {
      todoList.removeAt(index); // İndex numarasına göre görevi listeden kaldırıyoruz
    });
    _saveTasks(); // Değişiklikleri kaydediyoruz
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: const Color.fromARGB(255,196,174,233), 
      appBar: AppBar( // 
        title: Text(dateKey), // dd.mm.yyyy formatında seçili tarihi gösteren başlık
        centerTitle: true, 
        backgroundColor: Colors.deepPurple, 
        elevation: 0, 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask, // basıldığında createNewTask metodu çağrılacak
        child: const Icon(Icons.add), // Yeni görev ekleme butonu
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator()) // Görevler yüklenirken yükleme animasyonu
          : ListView.builder( // Görevler yüklendikten sonra liste görünümüyle görevler gösteriliyor
              itemCount: todoList.length, // Listenin eleman sayısı
              itemBuilder: (_, i) => ToDoTask(
                taskName: todoList[i][0], // Görev adı
                taskCompleted: todoList[i][1], // Görevin tamamlanma durumu
                onChanged: (v) => checkBoxChanged(v, i), // Checkbox değiştiğinde çağrılacak metot
                deleteFunction: (_) => deleteTask(i), // Silme butonuna basıldığında çağrılacak metot
              ),
            ),
    );
  }
}