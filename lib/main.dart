import 'package:flutter/material.dart';
import 'package:mon_app_couture/app/screens/init_screen.dart';
import 'package:mon_app_couture/core/theme.dart';
import 'routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(create: (_) => ThemeProvider(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Nippori',
      theme: customLightTheme,
      darkTheme: customDarkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: appRoutes(),
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const InitScreen());
      },
    );
  }
}
