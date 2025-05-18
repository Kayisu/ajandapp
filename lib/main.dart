import 'package:flutter/material.dart';
import 'package:todoapp/pages/calendar_page.dart';
import 'package:intl/date_symbol_data_local.dart';
// ignore: unused_import
import 'package:todoapp/pages/weather_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr_TR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalendarPage(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
