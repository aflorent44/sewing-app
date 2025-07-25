import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mon_app_couture/models/material_model.dart';
import 'package:mon_app_couture/services/api/material_service.dart';
import '../../models/fabric.dart';

final baseUrl = 'http://192.168.1.21:3000/fabric';

Future<List<Fabric>> fetchFabrics() async {
  final fabricsBox = Hive.box<Fabric>('fabrics');

  try {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      // 1. Tissus depuis le serveur
      final List<Fabric> serverFabrics = data.map((json) {
        final fabric = Fabric.fromJson(json);
        fabric.isSynced = true;
        return fabric;
      }).toList();


      // 2. Stockage dans Hive
      for (final fabric in serverFabrics) {
        
        if (fabric.id == null || fabric.id!.trim().isEmpty) {
          continue;
        }

        try {
          await fabricsBox.put(fabric.id, fabric);
        } catch (e) {
          print("❌ Erreur lors du stockage de ${fabric.name} : $e");
        }

      }
      // 3. Tissus locaux non synchronisés
      final unsyncedFabrics = fabricsBox.values
          .where((f) => f.isSynced == false)
          .toList();

      // 4. Retourne la fusion des deux
      return [...serverFabrics, ...unsyncedFabrics];
    } else {
      throw Exception('Erreur lors du chargement des tissus');
    }
  } catch (e) {
    // En cas d’erreur réseau → tous les tissus locaux (synced + non synced)
    return fabricsBox.values.toList();
  }
}

Future<void> saveFabric(Fabric fabric, List<String> toCreateMaterials) async {
  List<MaterialModel> savedMaterials = [];

  for (final newMatName in toCreateMaterials) {
    final createdMat = await saveMaterial(newMatName);
    savedMaterials.add(createdMat);
  }

  savedMaterials.addAll(fabric.materials ?? []);

  // On clone le JSON sans le champ 'id' pour ne PAS l’envoyer
  final fabricJson = fabric.toJson()
    ..remove('id') // Important ! On ne veut pas envoyer l’id local à Mongo
    ..['materials'] = savedMaterials.map((m) => m.id).toList();

  final response = await http.post(
    Uri.parse(baseUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(fabricJson),
  );

  if (response.statusCode == 201) {

    // (Optionnel mais utile) : enregistrer le _vrai_ id retourné par Mongo
    final data = jsonDecode(response.body);
    final newId = data['_id'];
    final updatedFabric = fabric.copyWith(id: newId, isSynced: true);

    await Hive.box<Fabric>('fabrics').put(newId, updatedFabric);
  } else {
    print('Erreur : ${response.statusCode} - ${response.body}');
  }
}

Future<void> updateFabric(
  String id,
  Fabric fabric,
  List<String> toCreateMaterials,
) async {
  List<MaterialModel> savedMaterials = [];

  for (final newMatName in toCreateMaterials) {
    final createdMat = await saveMaterial(newMatName);
    savedMaterials.add(createdMat);
  }

  savedMaterials.addAll(fabric.materials ?? []);

  final response = await http.put(
    Uri.parse('$baseUrl/$id'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      ...fabric.toJson(),
      'materials': savedMaterials.map((m) => m.id).toList(),
    }),
  );

  if (response.statusCode == 200) {
  } else {
    print('Erreur : ${response.statusCode} - ${response.body}');
  }
}

Future<void> saveFabricOffline(Fabric fabric) async {
  final fabricsBox = Hive.box<Fabric>('fabrics');
  fabric.isSynced = false;
  await fabricsBox.put(fabric.id, fabric);
}

Future<void> updateFabricOffline(Fabric fabric) async {
  final fabricsBox = Hive.box<Fabric>('fabrics');
  fabric.isSynced = false;
  await fabricsBox.put(fabric.id, fabric);
}

Future<void> deleteFabricOffline(String id) async {
  final fabricsBox = Hive.box<Fabric>('fabrics');
  await fabricsBox.delete(id);
}

// Future<void> syncFabrics() async {
//   final fabricsBox = Hive.box<Fabric>('fabrics');
//   final unsynced = fabricsBox.values.where((f) => !f.isSynced);

//   for (final fabric in unsynced) {
//     try {
//       final response = await http.put(
//         Uri.parse('http://192.168.1.21:3000/fabric/${fabric.id}'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(fabric.toJson()),
//       );

//       if (response.statusCode == 200) {
//         fabric.isSynced = true;
//         await fabricsBox.put(fabric.id, fabric);
//       }
//     } catch (e) {
//       // Pas grave, on réessaiera plus tard
//     }
//   }
// }

Future<void> deleteFabric(String id) async {
  final url = Uri.parse('$baseUrl/$id');
  deleteFabricOffline(id);
  final response = await http.delete(url);

  if (response.statusCode == 200) {
  } else {
    print('Erreur : ${response.statusCode} - ${response.body}');
  }
}

Future<List<Fabric>> fetchFabricsByKeyword(String searchTerm) async {
  try {
    final encodedSearchTerm = Uri.encodeQueryComponent(
      searchTerm,
    );
    final url = Uri.parse('$baseUrl/?search=$encodedSearchTerm');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Fabric.fromJson(json)).toList();
    } else {
      throw Exception(
        'Erreur lors du chargement des tissus: ${response.statusCode}',
      );
    }
  } catch (e) {
    rethrow; // Remonter l'erreur pour être catchée dans _onKeywordChanged
  }
}

