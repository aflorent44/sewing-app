import 'package:hive/hive.dart';
import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/enums/fabric_pattern.dart';
import 'package:mon_app_couture/models/enums/fabric_status.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/models/material_model.dart';
import 'package:mon_app_couture/models/enums/fabric_type.dart';

part 'fabric.g.dart';

@HiveType(typeId: 1)
class Fabric extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final FabricType? type;

  @HiveField(4)
  final String? brand;

  @HiveField(5)
  final String? weave;

  @HiveField(6)
  final List<MaterialModel>? materials;

  @HiveField(7)
  final List<Season>? seasons;

  @HiveField(8)
  final double? quantity;

  @HiveField(9)
  final List<Colour>? colours;

  @HiveField(10)
  final int? width;

  @HiveField(11)
  final double? extensiveness;

  @HiveField(12)
  final double? price;

  @HiveField(13)
  final List<String>? images;

  @HiveField(14)
  final String? link;

  @HiveField(15)
  final String? notes;

  @HiveField(16)
  final bool isFavorite;

  @HiveField(17)
  final String? userId;

  @HiveField(18)
  bool? isSynced;

  @HiveField(19)
  final bool isARemnant;

  @HiveField(20)
  final FabricPattern? fabricPattern;

  @HiveField(21)
  final FabricStatus? fabricStatus;

  @HiveField(22)
  final DateTime? createdAt;

  @HiveField(23)
  final DateTime? updatedAt;

  Fabric({
    this.id,
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
    this.isARemnant = false,
    this.fabricPattern,
    this.fabricStatus,
    this.extensiveness,
    this.price,
    this.images,
    this.link,
    this.notes,
    this.isFavorite = false,
    this.userId,
    this.isSynced = false,
    this.createdAt,
    this.updatedAt,
  });

  factory Fabric.fromJson(Map<String, dynamic> json) {
    return Fabric(
      id: json['_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      type: json['type'] != null ? FabricType.fromJson(json['type']) : null,
      brand: json['brand'] as String?,
      weave: json['weave'] as String?,
      materials: json['materials'] != null
          ? (json['materials'] as List<dynamic>).map((m) {
              if (m is String) {
                return MaterialModel(id: m, name: '');
              } else if (m is Map<String, dynamic>) {
                return MaterialModel.fromJson(m);
              } else {
                throw Exception('Format inattendu pour material: $m');
              }
            }).toList()
          : null,
      seasons:
          (json['seasons'] as List<dynamic>?)
              ?.map(
                (s) => s is String
                    ? Season.values.firstWhere((e) => e.name == s)
                    : Season.fromJson(s),
              )
              .toList() ??
          [],
      quantity: (json['quantity'] as num?)?.toDouble(),
      isARemnant: json['isARemnant'] as bool? ?? false,
      colours:
          (json['colours'] as List<dynamic>?)
              ?.map(
                (c) => c is String
                    ? Colour.values.firstWhere((e) => e.name == c)
                    : Colour.fromJson(c),
              )
              .toList() ??
          [],
      fabricPattern: json['fabricPattern'] != null
          ? FabricPattern.fromJson(json['fabricPattern'])
          : null,
      fabricStatus: json['fabricStatus'] != null
          ? FabricStatus.fromJson(json['fabricStatus'])
          : null,
      width: json['width'] as int?,
      extensiveness: (json['extensiveness'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      link: json['link'] as String?,
      notes: json['notes'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      isSynced: true,
      userId: json['user_id'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) '_id': id,
    'name': name,
    if (description != null) 'description': description,
    if (type != null) 'type': type!.toJson(),
    if (brand != null) 'brand': brand,
    if (weave != null) 'weave': weave,
    if (materials != null)
      'materials': materials!.map((m) => m.toJson()).toList(),
    if (seasons != null) 'seasons': seasons!.map((s) => s.toJson()).toList(),
    if (quantity != null) 'quantity': quantity,
    'isARemnant': isARemnant,
    if (colours != null) 'colours': colours!.map((c) => c.toJson()).toList(),
    if (fabricPattern != null) 'fabricPattern': fabricPattern!.toJson(),
    if (fabricStatus != null) 'fabricStatus': fabricStatus!.toJson(),
    if (width != null) 'width': width,
    if (extensiveness != null) 'extensiveness': extensiveness,
    if (price != null) 'price': price,
    if (images != null) 'images': images,
    if (link != null) 'link': link,
    if (notes != null) 'notes': notes,
    'isFavorite': isFavorite,
    if (userId != null) 'user_id': userId,
    if (createdAt != null) 'createdAt': createdAt,
    if (updatedAt != null) 'updatedAt': updatedAt
  };

  Fabric copyWith({
    String? id,
    String? name,
    String? description,
    FabricType? type,
    String? brand,
    String? weave,
    List<MaterialModel>? materials,
    List<Season>? seasons,
    double? quantity,
    bool? isARemnant,
    List<Colour>? colours,
    FabricPattern? fabricPattern,
    FabricStatus? fabricStatus,
    int? width,
    double? extensiveness,
    double? price,
    List<String>? images,
    String? link,
    String? notes,
    bool? isFavorite,
    String? userId,
    bool? isSynced,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Fabric(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    type: type ?? this.type,
    brand: brand ?? this.brand,
    weave: weave ?? this.weave,
    materials: materials ?? this.materials,
    seasons: seasons ?? this.seasons,
    quantity: quantity ?? this.quantity,
    isARemnant: isARemnant ?? this.isARemnant,
    colours: colours ?? this.colours,
    fabricPattern: fabricPattern ?? this.fabricPattern,
    fabricStatus: fabricStatus ?? this.fabricStatus,
    width: width ?? this.width,
    extensiveness: extensiveness ?? this.extensiveness,
    price: price ?? this.price,
    images: images ?? this.images,
    link: link ?? this.link,
    notes: notes ?? this.notes,
    isFavorite: isFavorite ?? this.isFavorite,
    userId: userId ?? this.userId,
    isSynced: isSynced ?? this.isSynced,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
