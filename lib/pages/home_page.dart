import 'package:flutter/material.dart';
import 'package:todoapp/pages/calendar_page.dart';
import 'package:todoapp/pages/todo_page.dart';
import 'package:todoapp/pages/weather_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,

        children: [
          CalendarPage(),
          TodoPage(selectedDate: DateTime.now()),
          WeatherPage(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 55, 29, 99), // Mor arka plan

          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.calendar_today, size: 32)),
            Tab(icon: Icon(Icons.edit_note, size: 32)),
            Tab(icon: Icon(Icons.wb_sunny, size: 32)),
          ],
          labelColor: const Color.fromARGB(197, 255, 255, 255), // Aktif ikon rengi
        ),
      ),
    );
  }
}
