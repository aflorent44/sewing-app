import 'package:mon_app_couture/models/brand.dart';
import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/fabric_type.dart';
import 'package:mon_app_couture/models/material.dart';
import 'package:mon_app_couture/models/enums/season.dart';

class Fabric {
  final String id;
  final String name;
  final String? description;
  final FabricType? type;
  final Brand? brand;
  final String? weave;
  final List<Material>? materials;
  final List<Season>? seasons;
  final double? quantity;
  final List<Colour>? colours;
  final int? width;
  final double? extensiveness;
  final double? price;
  final String? images;
  final String? link;
  final String? notes;
  final bool isFavorite;
  final String? userId;

  Fabric({
    required this.id,
    required this.name,
    this.description,
    this.type,
    this.brand,
    this.weave,
    this.materials,
    this.seasons,
    this.quantity,
    this.colours,
    this.width,
    this.extensiveness,
    this.price,
    this.images,
    this.link,
    this.notes,
    this.isFavorite = false,
    this.userId,
  });

  factory Fabric.fromJson(Map<String, dynamic> json) {
    if (json['_id'] == null || json['name'] == null) {
      throw Exception('Champ requis manquant dans Fabric');
    }

    return Fabric(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      type: json['type'] != null ? FabricType.fromJson(json['type']) : null,
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
      weave: json['weave'],
      materials: json['materials'] != null ? List<Material>.from(json['materials'].map((m) => Material.fromJson(m))) : null,
      seasons: json['seasons'] != null ? List<Season>.from(json['seasons'].map((s) => Season.fromJson(s))) : null,
      quantity: (json['quantity'] as num?)?.toDouble(),
      colours: json['colours'] != null ? List<Colour>.from(json['colours'].map((c) => Colour.fromJson(c))) : null,
      width: json['width'] as int? ?? 0,
      extensiveness: (json['extensiveness'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      images: json['images'],
      link: json['link'],
      notes: json['notes'],
      isFavorite: json['isFavorite'] ?? false,
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'type': type?.toJson(),
        'brand': brand?.toJson(),
        'weave': weave,
        'materials': materials?.map((m) => m.toJson()).toList(),
        'seasons': seasons?.map((s) => s.toJson()).toList(),
        'quantity': quantity,
        'colours': colours?.map((c) => c.toJson()).toList(),
        'width': width,
        'extensiveness': extensiveness,
        'price': price,
        'images': images,
        'link': link,
        'notes': notes,
        'isFavorite': isFavorite,
        'userId': userId,
      };
}