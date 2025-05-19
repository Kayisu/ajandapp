import 'package:flutter/material.dart';
import 'package:todoapp/pages/calendar_page.dart';
import 'package:todoapp/pages/todo_page.dart';
import 'package:todoapp/pages/weather_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
 late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:TabBarView(
        controller: _tabController,
        children: [
          CalendarPage(),
          TodoPage(selectedDate: DateTime.now()),
          WeatherPage(),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(icon: Icon(Icons.calendar_today)),
          Tab(icon: Icon(Icons.edit_note)),
          Tab(icon: Icon(Icons.wb_sunny)),
        ],
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        indicatorColor: Colors.deepPurple,
        indicatorWeight: 4.0,
      ),
    );
  }
}