import 'package:mon_app_couture/models/image_model.dart';

class Project {
  final String? id;
  final String name;
  final String? notes;
  final List<ImageModel>? images;
  final String? inspirationId;
  final String? patternId;
  final String? fabricId;
  final bool? isFavorite;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userId;

  const Project({
    this.id,
    required this.name,
    this.notes,
    this.images,
    this.inspirationId,
    this.patternId,
    this.fabricId,
    this.isFavorite,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['_id'] as String?,
      name: json['name'] as String,
      notes: json['notes'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      inspirationId: (json['inspiration'] is Map<String, dynamic>)
          ? json['inspiration']['_id'] as String?
          : json['inspiration'] as String?,
      patternId: (json['pattern'] is Map<String, dynamic>)
          ? json['pattern']['_id'] as String?
          : json['pattern'] as String?,
      fabricId: (json['fabric'] is Map<String, dynamic>)
          ? json['fabric']['_id'] as String?
          : json['fabric'] as String?,
      isFavorite: json['isFavorite'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      userId: json['user_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'name': name,
      if (notes != null) 'notes': notes,
      if (images != null) 'images': images!.map((e) => e.toJson()).toList(),
      if (inspirationId != null) 'inspiration': inspirationId,
      if (patternId != null) 'pattern': patternId,
      if (fabricId != null) 'fabric': fabricId,
      if (isFavorite != null) 'isFavorite': isFavorite,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
      if (userId != null) 'user_id': userId,
    };
  }

  Project copyWith({
    String? id,
    String? name,
    String? notes,
    List<ImageModel>? images,
    String? inspirationId,
    String? patternId,
    String? fabricId,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      images: images ?? this.images,
      inspirationId: inspirationId ?? this.inspirationId,
      patternId: patternId ?? this.patternId,
      fabricId: fabricId ?? this.fabricId,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }
}
