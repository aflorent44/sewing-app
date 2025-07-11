import 'package:flutter/material.dart';
import 'package:mon_app_couture/app/screens/init_screen.dart';
import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mon_app_couture/models/material_model.dart';
import 'package:mon_app_couture/models/fabric.dart';

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

  //await syncMaterials();
  //await syncFabrics();

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


// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:mon_app_couture/app/screens/init_screen.dart';
// import 'package:mon_app_couture/models/enums/colour.dart';
// import 'package:mon_app_couture/models/enums/season.dart';
// import 'package:mon_app_couture/models/fabric.dart';
// import 'package:mon_app_couture/models/material_model.dart';
// import 'package:mon_app_couture/routes.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Capture toutes les erreurs Flutter
//   FlutterError.onError = (FlutterErrorDetails details) {
//     FlutterError.dumpErrorToConsole(details);
//     // Tu peux aussi logger ça ailleurs ici si tu veux
//   };

//   // Capture les erreurs Dart non attrapées (async etc.)
//   PlatformDispatcher.instance.onError = (error, stack) {
//     print('Erreur Dart non attrapée : $error');
//     print('Stack trace : $stack');
//     return true; // empêche la propagation
//   };

//   try {
//     await Hive.initFlutter();
//   Hive.registerAdapter(FabricAdapter());
//       Hive.registerAdapter(MaterialModelAdapter());
//       Hive.registerAdapter(ColourAdapter());
//       Hive.registerAdapter(SeasonAdapter());

//     await Hive.openBox<MaterialModel>('materials');
//     await Hive.openBox<Fabric>('fabrics');


//     runApp(const MonAppCouture());
//   } catch (e, st) {
//     print('Erreur dans main(): $e\n$st');
//   }
// }

// class MonAppCouture extends StatelessWidget {
//   const MonAppCouture({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Mon App Couture',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color.fromARGB(255, 200, 168, 179),
//         ),
//         useMaterial3: true,
//       ),
//       initialRoute: '/',
//       routes: appRoutes,
//       onUnknownRoute: (settings) {
//         return MaterialPageRoute(builder: (context) => const InitScreen());
//       },
//     );
//   }
// }
