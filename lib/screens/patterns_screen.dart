import 'package:flutter/material.dart';

class PatternsScreen extends StatefulWidget {
  const PatternsScreen({super.key});

  @override
  State<PatternsScreen> createState() => _PatternsScreenState();
}

class _PatternsScreenState extends State<PatternsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Patrons")));
  }
}