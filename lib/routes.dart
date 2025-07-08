import 'package:flutter/material.dart';
import 'app/screens/welcome_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/register_screen.dart';
import 'app/screens/init_screen.dart';
import 'app/screens/main_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/main': (context) => const MainScreen(),
  '/welcome': (context) => const WelcomeScreen(),
  '/': (context) => const InitScreen(),
  };
