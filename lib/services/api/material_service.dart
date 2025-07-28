import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mon_app_couture/models/material_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = "${dotenv.env['BASE_URL']!}/material";

Future<List<MaterialModel>> fetchMaterials() async {
  try {
    final url = Uri.parse(baseUrl);
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
    rethrow;
  }
}

Future<MaterialModel> saveMaterial(String name) async {
  try {
    final url = Uri.parse(baseUrl);
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