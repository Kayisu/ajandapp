import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todoapp/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that Flutter is initialized before running the app
  await initializeDateFormatting('tr_TR', null); // Initialize date formatting for Turkish locale
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
