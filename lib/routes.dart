import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/init_screen.dart';
import 'screens/main_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/main': (context) => const MainScreen(),
  '/home': (context) => const HomeScreen(),
  '/welcome': (context) => const WelcomeScreen(),
  '/': (context) => const InitScreen(),
  };
