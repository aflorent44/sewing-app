import 'package:flutter/material.dart';
import 'package:mon_app_couture/app/screens/init_screen.dart';
import 'routes.dart';

void main() {
  runApp(const MonAppCouture());
}

class MonAppCouture extends StatelessWidget {
  const MonAppCouture({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon App Couture',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 200, 168, 179),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: appRoutes,
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const InitScreen());
      },
    );
  }
}
