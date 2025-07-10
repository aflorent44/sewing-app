class MaterialModel {
  final String id;
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