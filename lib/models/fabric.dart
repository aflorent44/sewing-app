import 'package:mon_app_couture/models/brand.dart';
import 'package:mon_app_couture/models/colour.dart';
import 'package:mon_app_couture/models/fabric_type.dart';
import 'package:mon_app_couture/models/material.dart';
import 'package:mon_app_couture/models/season.dart';

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
    return Fabric(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: json['type'] != null ? FabricType.fromJson(json['type']) : null,
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
      weave: json['weave'],
      materials: json['materials'] != null ? List<Material>.from(json['materials'].map((m) => Material.fromJson(m))) : null,
      seasons: json['seasons'] != null ? List<Season>.from(json['seasons'].map((s) => Season.fromJson(s))) : null,
      quantity: json['quantity'],
      colours: json['colours'] != null ? List<Colour>.from(json['colours'].map((c) => Colour.fromJson(c))) : null,
      width: json['width'],
      extensiveness: json['extensiveness'],
      price: json['price'],
      images: json['images'],
      link: json['link'],
      notes: json['notes'],
      isFavorite: json['isFavorite'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
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