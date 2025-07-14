import 'package:flutter/material.dart';
import 'package:mon_app_couture/app/screens/init_screen.dart';
import 'package:mon_app_couture/app/screens/main_screen.dart';
import 'package:mon_app_couture/app/screens/welcome_screen.dart';
import 'package:mon_app_couture/features/auth/login_screen.dart';
import 'package:mon_app_couture/features/auth/register_screen.dart';
import 'package:mon_app_couture/features/profile/profile_screen.dart';

Map<String, WidgetBuilder> appRoutes() => {
  '/login': (context) => LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/main': (context) => MainScreen(),
  '/welcome': (context) => const WelcomeScreen(),
  '/': (context) => const InitScreen(),
  '/profile': (context) => ProfileScreen(),
};
