class FabricType {
  final String id;
  final String name;  

  FabricType({required this.id, required this.name});
  
  factory FabricType.fromJson(Map<String, dynamic> json) {
    return FabricType(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

//chaine et trame, maille, cuir, etc