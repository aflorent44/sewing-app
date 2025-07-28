import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mon_app_couture/models/image_model.dart';
import 'package:mon_app_couture/models/material_model.dart';
import 'package:mon_app_couture/services/api/material_service.dart';
import 'package:mon_app_couture/services/api/image_service.dart';
import '../../models/fabric.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = "${dotenv.env['BASE_URL']!}/fabric";
final _secureStorage = FlutterSecureStorage();

Future<Map<String, String>> getAuthHeaders() async {
  final token = await _secureStorage.read(key: 'jwt_token');
  return {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
}

Future<List<Fabric>> fetchFabrics() async {
  try {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: await getAuthHeaders(),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      final List<Fabric> fabrics = data.map((json) {
        final fabric = Fabric.fromJson(json);
        return fabric;
      }).toList();

      return fabrics;
    } else {
      throw Exception('Erreur lors du chargement des tissus');
    }
  } catch (e) {
    rethrow;
  }
}

Future<void> saveFabric(
  Fabric fabric,
  List<String> toCreateMaterials,
  List<ImageModel> toCreateImages, // Images locales à uploader
) async {
  try {
    print('=== DEBUT saveFabric ===');
    print('Matériaux à créer: $toCreateMaterials');
    print('Images à créer: ${toCreateImages.length}');

    // Étape 1 : Créer les matériaux dynamiques
    final List<MaterialModel> savedMaterials = [];
    for (final newMatName in toCreateMaterials) {
      print('Création matériau: $newMatName');
      final createdMat = await saveMaterial(newMatName);
      savedMaterials.add(createdMat);
    }

    // Étape 2 : Ajouter les matériaux déjà sélectionnés
    savedMaterials.addAll(fabric.materials ?? []);
    print('Total matériaux: ${savedMaterials.length}');

    // Étape 3 : Créer le tissu sans les images
    final fabricJson = fabric.toJson()
      ..remove('_id')
      ..['materials'] = savedMaterials.map((m) => m.id).toList()
      ..remove('images'); // Important : ne pas envoyer d'images encore

    print('Création tissu avec données: ${fabricJson.keys}');

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: await getAuthHeaders(),
      body: jsonEncode(fabricJson),
    );

    if (response.statusCode != 201) {
      print(
        'Erreur création tissu : ${response.statusCode} - ${response.body}',
      );
      throw Exception('Erreur création tissu: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    final newFabricId = data['_id'];
    print('Tissu créé avec ID: $newFabricId');

    // Étape 4 : Uploader les fichiers image liés au tissu nouvellement créé
    final List<ImageModel> uploadedImages = [];
    for (int i = 0; i < toCreateImages.length; i++) {
      final image = toCreateImages[i];
      print('Upload image ${i + 1}/${toCreateImages.length}: ${image.url}');

      try {
        final uploadedImage = await uploadImageFile(
          imageFile: File(image.url), // Chemin local
          type: 'fabric',
          refId: newFabricId,
          alt: image.alt ?? '',
        );
        uploadedImages.add(uploadedImage);
        print('Image uploadée: ${uploadedImage.id}');
      } catch (e) {
        print('Erreur upload image ${i + 1}: $e');
        // Continue avec les autres images même si une échoue
      }
    }

    // Étape 5 : PATCH le tissu avec les images uploadées
    if (uploadedImages.isNotEmpty) {
      print('Mise à jour tissu avec ${uploadedImages.length} images');

      final updateResponse = await http.put(
        Uri.parse('$baseUrl/$newFabricId'),
        headers: await getAuthHeaders(),
        body: jsonEncode({
          'images': uploadedImages.map((img) => img.id).toList(),
        }),
      );

      if (updateResponse.statusCode != 200) {
        print(
          'Erreur mise à jour images: ${updateResponse.statusCode} - ${updateResponse.body}',
        );
      } else {
        print('Images associées au tissu avec succès');
      }
    }

    print('=== FIN saveFabric ===');
  } catch (e) {
    print('Erreur dans saveFabric : $e');
    rethrow;
  }
}

Future<void> updateFabric(
  String id,
  Fabric fabric,
  List<String> toCreateMaterials,
  List<ImageModel> toCreateImages, // Images locales à uploader
  List<ImageModel> existingImages, // Images déjà sur le serveur
) async {
  try {
    print('=== DEBUT updateFabric ===');
    print('ID tissu: $id');
    print('Matériaux à créer: $toCreateMaterials');
    print('Images à créer: ${toCreateImages.length}');
    print('Images existantes: ${existingImages.length}');

    // Étape 1 : Créer les nouveaux matériaux
    List<MaterialModel> savedMaterials = [];
    for (final newMatName in toCreateMaterials) {
      print('Création matériau: $newMatName');
      final createdMat = await saveMaterial(newMatName);
      savedMaterials.add(createdMat);
    }

    // Ajouter les matériaux existants
    savedMaterials.addAll(fabric.materials ?? []);

    // Étape 2 : Uploader les nouvelles images
    List<ImageModel> uploadedImages = [];
    for (int i = 0; i < toCreateImages.length; i++) {
      final image = toCreateImages[i];
      print(
        'Upload nouvelle image ${i + 1}/${toCreateImages.length}: ${image.url}',
      );

      try {
        final uploadedImage = await uploadImageFile(
          imageFile: File(image.url),
          type: 'fabric',
          refId: id,
          alt: image.alt ?? '',
        );
        uploadedImages.add(uploadedImage);
        print('Image uploadée: ${uploadedImage.id}');
      } catch (e) {
        print('Erreur upload image ${i + 1}: $e');
      }
    }

    // Étape 3 : Combiner toutes les images (existantes + nouvelles)
    final allImages = [...existingImages, ...uploadedImages];
    print('Total images après upload: ${allImages.length}');

    // Étape 4 : Mettre à jour le tissu
    final updateData = {
      ...fabric.toJson(),
      'materials': savedMaterials.map((m) => m.id).toList(),
      'images': allImages.map((i) => i.id).toList(),
    };

    // Nettoyer les champs non nécessaires
    updateData.remove('_id');
    updateData.remove('createdAt');
    updateData.remove('updatedAt');

    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: await getAuthHeaders(),
      body: jsonEncode(updateData),
    );

    if (response.statusCode != 200) {
      print(
        'Erreur mise à jour tissu: ${response.statusCode} - ${response.body}',
      );
      throw Exception('Erreur mise à jour tissu: ${response.statusCode}');
    }

    print('Tissu mis à jour avec succès');
    print('=== FIN updateFabric ===');
  } catch (e) {
    print('Erreur dans updateFabric : $e');
    rethrow;
  }
}

Future<void> deleteFabric(String id) async {
  try {
    print('Suppression tissu: $id');

    final url = Uri.parse('$baseUrl/$id');
    final response = await http.delete(url, headers: await getAuthHeaders());

    if (response.statusCode == 200) {
      print('Tissu supprimé avec succès');
    } else {
      print(
        'Erreur suppression tissu : ${response.statusCode} - ${response.body}',
      );
      throw Exception('Erreur suppression tissu: ${response.statusCode}');
    }
  } catch (e) {
    print('Erreur dans deleteFabric : $e');
    rethrow;
  }
}

Future<List<Fabric>> fetchFabricsByKeyword(String searchTerm) async {
  try {
    final encodedSearchTerm = Uri.encodeQueryComponent(searchTerm);
    final url = Uri.parse('$baseUrl/?search=$encodedSearchTerm');
    final response = await http.get(url, headers: await getAuthHeaders());

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Fabric.fromJson(json)).toList();
    } else {
      throw Exception(
        'Erreur lors du chargement des tissus: ${response.statusCode}',
      );
    }
  } catch (e) {
    rethrow;
  }
}
