class Colour {
  final String id;
  final String name;

  Colour({required this.id, required this.name});

  factory Colour.fromJson(Map<String, dynamic> json) => Colour(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
