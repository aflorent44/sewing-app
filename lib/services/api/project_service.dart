import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mon_app_couture/models/image_model.dart';
import 'package:mon_app_couture/models/project.dart';
import 'package:mon_app_couture/services/api/image_service.dart';

final baseUrl = "${dotenv.env['BASE_URL']!}/project";
final _secureStorage = FlutterSecureStorage();

Future<Map<String, String>> getAuthHeaders() async {
  final token = await _secureStorage.read(key: 'jwt_token');
  return {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
}

Future<List<Project>> fetchProjects() async {
  print('=== DEBUT fetchProjects ===');

  try {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: await getAuthHeaders(),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Project> projects = data.map((json) {
        final element = Project.fromJson(json);
        return element;
      }).toList();
      return projects;
    } else {
      throw Exception('Erreur lors du chargement des projets');
    }
  } catch (e) {
    rethrow;
  }
}

Future<void> saveProject(
  Project project,
  List<ImageModel> toCreateImages,
) async {
  try {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: await getAuthHeaders(),
      body: jsonEncode(
        project.toJson()
          ..remove('_id')
          ..remove('images'),
      ),
    );

    if (response.statusCode != 201) {
      throw Exception('Erreur lors de la sauvegarde du projet');
    }

    final data = jsonDecode(response.body);
    final newId = data['_id'];
    print('Projet créé avec ID: $newId');

    final List<ImageModel> uploadedImages = [];
    for (int i = 0; i < toCreateImages.length; i++) {
      final image = toCreateImages[i];
      print('Upload image ${i + 1}/${toCreateImages.length}: ${image.url}');

      try {
        final uploadedImage = await uploadImageFile(
          imageFile: File(image.url),
          type: 'project',
          refId: newId,
          alt: image.alt ?? '',
        );
        uploadedImages.add(uploadedImage);
      } catch (e) {
        print('Erreur lors de l\'upload de l\'image: $e');
      }
    }

    if (uploadedImages.isNotEmpty) {
      final updateResponse = await http.put(
        Uri.parse('$baseUrl/$newId'),
        headers: await getAuthHeaders(),
        body: jsonEncode({
          'images': uploadedImages.map((image) => image.id).toList(),
        }),
      );

      if (updateResponse.statusCode != 200) {
        print(
          'Erreur lors de la mise à jour des images du projet: ${updateResponse.statusCode}',
        );
      } else {
        print('Images du projet mis à jour');
      }
    }
  } catch (e) {
    rethrow;
  }
}

Future<void> updateProject(
  String id,
  Project project,
  List<ImageModel> toCreateImages,
  List<ImageModel> existingImages,
) async {
  print('=== DEBUT updateProject ===');
  try {
    List<ImageModel> uploadedImages = [];
    for (int i = 0; i < toCreateImages.length; i++) {
      final image = toCreateImages[i];
      print('Upload image ${i + 1}/${toCreateImages.length}: ${image.url}');

      try {
        final uploadedImage = await uploadImageFile(
          imageFile: File(image.url),
          type: 'project',
          refId: id,
          alt: image.alt ?? '',
        );
        uploadedImages.add(uploadedImage);
      } catch (e) {
        print('Erreur lors de l\'upload de l\'image: $e');
      }
    }

    final allImages = [...existingImages, ...uploadedImages];

    final updateData = {
      ...project.toJson(),
      'images': allImages.map((i) => i.id).toList(),
    };

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
        'Erreur mise à jour projet: ${response.statusCode} - ${response.body}',
      );
      throw Exception('Erreur mise à jour projet: ${response.statusCode}');
    }
  } catch (e) {
    rethrow;
  }
}

Future<void> deleteProject(String id) async {
  try {
    print('Suppression projet: $id');

    final url = Uri.parse('$baseUrl/$id');
    final response = await http.delete(url, headers: await getAuthHeaders());

    if (response.statusCode == 200) {
      print('Projet supprimé avec succès');
    } else {
      print(
        'Erreur suppression projet : ${response.statusCode} - ${response.body}',
      );
      throw Exception('Erreur suppression projet: ${response.statusCode}');
    }
  } catch (e) {
    print('Erreur dans deleteProject : $e');
    rethrow;
  }
}
