import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/models/material_model.dart';
import 'package:mon_app_couture/services/api/material_service.dart';
import '../../models/fabric.dart';

Future<List<Fabric>> fetchFabrics() async {
  final url = Uri.parse(
    'http://192.168.1.21:3000/fabric',
  ); // Mets ton IP locale

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    return data.map((json) => Fabric.fromJson(json)).toList();
  } else {
    throw Exception('Erreur lors du chargement des tissus');
  }
}

Future<void> saveFabric(
  String name,
  String description,
  String quantity,
  String width,
  List<Season> seasons,
  List<Colour> colours,
  List<MaterialModel> selectedMaterials,
  List<String> toCreateMaterials,
  String notes,
) async {
  List<MaterialModel> savedMaterials = [];

  // 1. Enregistrer les nouveaux matériaux à créer un par un
  for (final newMatName in toCreateMaterials) {
    final createdMat = await saveMaterial(newMatName);
    savedMaterials.add(createdMat);
  }

  // 2. Ajouter les matériaux déjà existants sélectionnés
  savedMaterials.addAll(selectedMaterials);

  // 3. Poster le tissu avec la liste complète des matériaux (existant + créés)
  final url = Uri.parse('http://192.168.1.21:3000/fabric');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': name,
      'description': description,
      'quantity': double.tryParse(quantity) ?? 0.0,
      'width': double.tryParse(width) ?? 0,
      'seasons': seasons.map((s) => s.name).toList(),
      'colours': colours.map((c) => c.name).toList(),
      'materials': savedMaterials.map((m) => m.id).toList(),
      'notes': notes,
    }),
  );

  if (response.statusCode == 201) {
    print('Tissu ajouté avec succès');
  } else {
    print('Erreur : ${response.statusCode} - ${response.body}');
  }
}

Future<void> updateFabric(
  String id,
  String name,
  String description,
  String quantity,
  String width,
  List<Season> seasons,
  List<Colour> colours,
  List<MaterialModel> selectedMaterials,
  List<String> toCreateMaterials,
  String notes,
) async {
  List<MaterialModel> savedMaterials = [];

  for (final newMatName in toCreateMaterials) {
    final createdMat = await saveMaterial(newMatName);
    savedMaterials.add(createdMat);
  }

  savedMaterials.addAll(selectedMaterials);

  final url = Uri.parse('http://192.168.1.21:3000/fabric/$id');

  final response = await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': name,
      'description': description,
      'quantity': double.tryParse(quantity) ?? 0.0,
      'width': double.tryParse(width) ?? 0,
      'seasons': seasons.map((s) => s.name).toList(),
      'colours': colours.map((c) => c.name).toList(),
      'materials': savedMaterials.map((mat) => mat.id).toList(),
      'notes': notes,
    }),
  );

  if (response.statusCode == 200) {
    print('Tissu mis à jour avec succès');
  } else {
    print('Erreur : ${response.statusCode} - ${response.body}');
  }
}

Future<void> deleteFabric(String id) async {
  final url = Uri.parse('http://192.168.1.21:3000/fabric/$id');

  final response = await http.delete(url);

  if (response.statusCode == 200) {
    print('Tissu supprimé avec succès');
  } else {
    print('Erreur : ${response.statusCode} - ${response.body}');
  }
}
