class Material {
  final String id;
  final String name;

  Material({required this.id, required this.name});

  factory Material.fromJson(Map<String, dynamic> json) {
    return Material(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

//coton, laine, soie, nylon