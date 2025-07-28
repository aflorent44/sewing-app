import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mon_app_couture/models/image_model.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = "${dotenv.env['BASE_URL']!}/image";
final _secureStorage = FlutterSecureStorage();

Future<Map<String, String>> getAuthHeaders() async {
  final token = await _secureStorage.read(key: 'jwt_token');
  return {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
}

Future<Map<String, String>> getMultipartAuthHeaders() async {
  final token = await _secureStorage.read(key: 'jwt_token');
  return {'Authorization': 'Bearer $token'};
}

Future<ImageModel> uploadImageFile({
  required File imageFile,
  required String type,
  String? refId,
  String? alt,
}) async {
  try {
    print('=== DEBUT uploadImageFile ===');
    print('Fichier: ${imageFile.path}');
    print('Type: $type');
    print('RefId: $refId');
    print('Alt: $alt');

    final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/upload'));

    // Ajouter les en-têtes d'authentification
    request.headers.addAll(await getMultipartAuthHeaders());

    // Ajouter les champs
    request.fields['type'] = type;
    if (refId != null && refId.isNotEmpty) {
      request.fields['refId'] = refId;
    }
    if (alt != null && alt.isNotEmpty) {
      request.fields['alt'] = alt; // CORRECTION: c'était 'refId' avant
    }

    // Vérifier que le fichier existe
    if (!await imageFile.exists()) {
      throw Exception('Le fichier image n\'existe pas: ${imageFile.path}');
    }

    // Ajouter le fichier
    request.files.add(
      await http.MultipartFile.fromPath('image', imageFile.path),
    );

    print('Envoi de la requête multipart...');
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print('Réponse upload: ${response.statusCode}');
    print('Corps réponse: ${response.body}');

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final imageModel = ImageModel.fromJson(data);
      print('Image uploadée avec succès: ${imageModel.id}');
      print('=== FIN uploadImageFile ===');
      return imageModel;
    } else {
      print('Erreur upload: ${response.statusCode} - ${response.body}');
      throw Exception(
        'Erreur upload image : ${response.statusCode} - ${response.body}',
      );
    }
  } catch (e) {
    print('Exception dans uploadImageFile: $e');
    rethrow;
  }
}

Future<List<ImageModel>> fetchImages() async {
  try {
    print('Récupération de toutes les images...');

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: await getAuthHeaders(),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final images = data.map((json) => ImageModel.fromJson(json)).toList();
      print('${images.length} images récupérées');
      return images;
    } else {
      print(
        'Erreur récupération images: ${response.statusCode} - ${response.body}',
      );
      throw Exception(
        'Erreur lors du chargement des images: ${response.statusCode}',
      );
    }
  } catch (e) {
    print('Exception dans fetchImages: $e');
    rethrow;
  }
}

Future<List<ImageModel>> fetchImagesByRefId(String refId) async {
  try {
    print('Récupération images pour refId: $refId');

    final allImages = await fetchImages();
    final filteredImages = allImages
        .where((img) => img.refId == refId)
        .toList();

    print('${filteredImages.length} images trouvées pour refId: $refId');
    return filteredImages;
  } catch (e) {
    print('Exception dans fetchImagesByRefId: $e');
    rethrow;
  }
}

Future<void> deleteImageById(String id) async {
  try {
    print('Suppression image: $id');

    final url = Uri.parse('$baseUrl/$id');
    final response = await http.delete(url, headers: await getAuthHeaders());

    if (response.statusCode == 200) {
      print('Image supprimée avec succès: $id');
    } else {
      print(
        'Erreur suppression image: ${response.statusCode} - ${response.body}',
      );
      throw Exception('Erreur suppression image: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception dans deleteImageById: $e');
    rethrow;
  }
}

Future<ImageModel> fetchImageById(String id) async {
  try {
    print('Récupération image: $id');

    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url, headers: await getAuthHeaders());

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final image = ImageModel.fromJson(data);
      print('Image récupérée: ${image.id}');
      return image;
    } else {
      print(
        'Erreur récupération image: ${response.statusCode} - ${response.body}',
      );
      throw Exception('Image introuvable: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception dans fetchImageById: $e');
    rethrow;
  }
}
