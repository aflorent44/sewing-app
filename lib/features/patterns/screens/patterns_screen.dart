import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PatternsScreen extends StatefulWidget {
  const PatternsScreen({super.key});

  @override
  State<PatternsScreen> createState() => _PatternsScreenState();
}

class _PatternsScreenState extends State<PatternsScreen> {
  void saveName() async {
    var box = await Hive.openBox('settings');
    await box.put('username', 'Amélie');
  }

  void loadName() async {
    var box = await Hive.openBox('settings');
    print('Nom : ${box.get('username')}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Patrons"),
            ElevatedButton(onPressed: () => loadName(), child: Text("Charger")),
          ],
        ),
      ),
    );
  }
}
