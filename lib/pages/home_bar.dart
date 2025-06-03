import 'package:flutter/material.dart';
import 'package:todoapp/pages/calendar_page.dart';
import 'package:todoapp/pages/todo_page.dart';
import 'package:todoapp/pages/weather_page.dart';

class HomeBar extends StatefulWidget { //Navigation bar, diğer sayfalara geçişi sağlayan widget 
  const HomeBar({super.key});

  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar>
    with SingleTickerProviderStateMixin { //Tick Provider ile animasyonları kontrol ediyoruz
  late TabController _tabController; // TabController ile sekmeleri kontrol ediyoruz

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 sekme için TabController oluşturuyoruz
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView( // TabBarView ile sekmelerin içeriğini gösteriyoruz
        controller: _tabController, 

        children: [ // TabBarView içinde gösterilecek sayfaların instance'ları, diğer sayfalar bu sayfa içinde gösterilecek
          CalendarPage(), 
          TodoPage(selectedDate: DateTime.now()),
          WeatherPage(),
        ],
      ),
      bottomNavigationBar: Container( //Navigasyonun altta olması için bottomNavigationBar 
        height: 70,
        decoration: const BoxDecoration( // Navigasyon bar stili
          color: Color.fromARGB(255, 215, 213, 219), 
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: TabBar( // TabBar ile sayfa sekmelerini oluşturuyoruz
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.calendar_today, size: 32)),
            Tab(icon: Icon(Icons.edit_note, size: 32)),
            Tab(icon: Icon(Icons.wb_sunny, size: 32)),
          ],
          labelColor: const Color.fromARGB(197, 255, 255, 255), // Aktif ikon
        ),
      ),
    );
  }
}
