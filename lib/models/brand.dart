class Brand {
  final String id;
  final String name;
  
  Brand({required this.id, required this.name});
  
  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
    );
  }
  
  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}