import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme(); // charge au démarrage
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', _isDarkMode);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners(); // pour que MyApp se rebuild avec le bon mode
  }
}

final ThemeData customLightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFFFF8E1), // jaune pâle
  primaryColor: const Color(0xFFFFB74D), // orange doux
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.deepOrange,
    accentColor: Colors.amberAccent,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFFCC80), // orange pastel
    foregroundColor: Colors.black,
    elevation: 0,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFFFCC80)),
  cardColor: Colors.white,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black54),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFFA726), // orange vif
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.deepOrange),
);

final ThemeData customDarkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF2E2E2E),
  primaryColor: const Color(0xFF9575CD), // violet doux
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple,
    accentColor: Colors.amber,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF3E3E3E),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF3E3E3E)),
  cardColor: const Color(0xFF424242),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.grey),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF7E57C2),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.deepPurpleAccent),
);
