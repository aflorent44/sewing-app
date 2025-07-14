import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mon_app_couture/models/material_model.dart';

Future<List<MaterialModel>> fetchMaterials() async {
  final materialsBox = Hive.box<MaterialModel>('materials');

  try {
    final url = Uri.parse('http://192.168.1.21:3000/material');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      final List<MaterialModel> serverMaterials = data.map((json) {
        final material = MaterialModel.fromJson(json);
        return material;
      }).toList();

      // for (final material in serverMaterials) {
      //   await materialsBox.put(material.id, material);
      // }
      return serverMaterials;
    } else {
      throw Exception('Erreur lors du chargement des matériaux');
    }
  } catch (e) {
    return materialsBox.values.toList();
  }
}

Future<MaterialModel> saveMaterial(String name) async {
  try {
    final url = Uri.parse('http://192.168.1.21:3000/material');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return MaterialModel.fromJson(data);
    } else {
      throw Exception(
        'Erreur lors de la création du matériau : ${response.body}',
      );
    }
  } catch (e) {
    rethrow;
  }
}

Future<void> saveMaterialOffline(MaterialModel material) async {
  final materialsBox = Hive.box<MaterialModel>('materials');
  await materialsBox.put(material.id, material);
}
