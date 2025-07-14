import 'package:flutter/material.dart';
import 'package:mon_app_couture/app/screens/init_screen.dart';
import 'package:mon_app_couture/core/theme.dart';
import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mon_app_couture/models/material_model.dart';
import 'package:mon_app_couture/models/fabric.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };

  await Hive.initFlutter();
  Hive.registerAdapter(FabricAdapter());
  Hive.registerAdapter(MaterialModelAdapter());
  Hive.registerAdapter(ColourAdapter());
  Hive.registerAdapter(SeasonAdapter());

  await Hive.openBox<MaterialModel>('materials');
  await Hive.openBox<Fabric>('fabrics');

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Mon App Couture',
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
