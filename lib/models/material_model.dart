import 'package:hive/hive.dart';

part 'material_model.g.dart'; // 1 fichier à créer via build_runner

@HiveType(typeId: 0) // Chaque typeId doit être unique dans ton projet Hive
class MaterialModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  MaterialModel({required this.id, required this.name});

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  String toString() {
    return 'MaterialModel{id: $id, name: $name}';
  }
}



//coton, laine, soie, nylon