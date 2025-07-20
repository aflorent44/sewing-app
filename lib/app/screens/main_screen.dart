import 'package:flutter/material.dart';
import 'package:mon_app_couture/features/fabrics/screens/fabrics_screen.dart';
import 'package:mon_app_couture/features/patterns/screens/patterns_screen.dart';
import 'package:mon_app_couture/features/profile/profile_screen.dart';
import 'package:mon_app_couture/features/projects/screens/projects_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    FabricsScreen(),
    PatternsScreen(),
    ProjectsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Tissus'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Patrons'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Projets'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(
          context,
        ).colorScheme.onSurface.withValues(alpha: 0.6),
        backgroundColor: Theme.of(context).bottomAppBarTheme.color,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
