import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// Sadece Bottom NavBar için widget
class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: GNav(
          backgroundColor: const Color.fromARGB(255, 34, 12, 95),
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: const Color.fromARGB(255, 153, 123, 235),
          gap: 8,
          onTabChange: (index) {
            print(index);
          },
          padding: EdgeInsets.all(16),
          tabs: const [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.calendar_today, text: 'Calendar'),
            GButton(icon: Icons.wb_sunny, text: 'Weather'),
            GButton(icon: Icons.settings, text: 'Settings'),
          ],
        ),
      ),
    );
  }
}
