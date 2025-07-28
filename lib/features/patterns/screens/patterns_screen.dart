import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/image_model.dart';
import 'package:mon_app_couture/services/api/image_service.dart';

class PatternsScreen extends StatefulWidget {
  const PatternsScreen({super.key});

  @override
  State<PatternsScreen> createState() => _PatternsScreenState();
}

class _PatternsScreenState extends State<PatternsScreen> {
  late Future<List<ImageModel>> images;

  @override
  void initState() {
    super.initState();
    images = fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Patrons")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [const Padding(padding: EdgeInsets.all(8.0))],
      ),
    );
  }
}
