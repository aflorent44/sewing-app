// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// Dans votre project.g.dart, remplacez la méthode _$ProjectImplFromJson par :

_$ProjectImpl _$$ProjectImplFromJson(Map<String, dynamic> json) {
  print('fromjson : $json');
  return _$ProjectImpl(
    id: json['_id'] as String?,
    name: json['name'] as String,
    notes: json['notes'] as String?,
    images: (json['images'] as List<dynamic>?)
        ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    // Extraire l'ID de l'objet inspiration s'il est populé, sinon utiliser inspirationId
    inspirationId: json['inspiration'] != null
        ? (json['inspiration'] is Map<String, dynamic>
              ? json['inspiration']['_id'] as String?
              : json['inspiration'] as String?)
        : json['inspirationId'] as String?,
    // Extraire l'ID de l'objet pattern s'il est populé, sinon utiliser patternId
    patternId: json['pattern'] != null
        ? (json['pattern'] is Map<String, dynamic>
              ? json['pattern']['_id'] as String?
              : json['pattern'] as String?)
        : json['patternId'] as String?,
    // Extraire l'ID de l'objet fabric s'il est populé, sinon utiliser fabricId
    fabricId: json['fabric'] != null
        ? (json['fabric'] is Map<String, dynamic>
              ? json['fabric']['_id'] as String?
              : json['fabric'] as String?)
        : json['fabricId'] as String?,
    isFavorite: json['isFavorite'] as bool?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    userId: json['userId'] as String?,
  );
}

Map<String, dynamic> _$$ProjectImplToJson(_$ProjectImpl instance) {
  print("tojson : $instance");
  return <String, dynamic>{
    '_id': instance.id,
    'name': instance.name,
    'notes': instance.notes,
    'images': instance.images,
    'inspirationId': instance.inspirationId,
    'patternId': instance.patternId,
    'fabricId': instance.fabricId,
    'isFavorite': instance.isFavorite,
    'createdAt': instance.createdAt?.toIso8601String(),
    'updatedAt': instance.updatedAt?.toIso8601String(),
    'userId': instance.userId,
  };
}
