class Fabric {
  final String id;
  final String name;
  final String type;
  final double quantity;

  Fabric({
    required this.id,
    required this.name,
    required this.type,
    required this.quantity,
  });

  factory Fabric.fromJson(Map<String, dynamic> json) {
    return Fabric(
      id: json['_id'],
      name: json['name'],
      type: json['type'],
      quantity: (json['quantity'] as num).toDouble(),
    );
  }
}
