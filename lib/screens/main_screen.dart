import 'package:flutter/material.dart';
import 'package:mon_app_couture/screens/fabric/fabric_list_screen.dart';
import 'package:mon_app_couture/screens/patterns_screen.dart';
import 'package:mon_app_couture/screens/profile_screen.dart';
import 'package:mon_app_couture/screens/projects_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

final List<Widget> _pages = [
    FabricsScreen(),
    PatternsScreen(),
    ProjectsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bienvenue !')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Tissus'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Patrons'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Projets'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 161, 93, 152),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
