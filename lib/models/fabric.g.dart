// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fabric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FabricImpl _$$FabricImplFromJson(Map<String, dynamic> json) => _$FabricImpl(
      id: json['_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      type: $enumDecodeNullable(_$FabricTypeEnumMap, json['type']),
      brand: json['brand'] as String?,
      weave: json['weave'] as String?,
      materials: (json['materials'] as List<dynamic>?)
          ?.map((e) => MaterialModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$SeasonEnumMap, e))
          .toList(),
      quantity: (json['quantity'] as num?)?.toDouble(),
      colours: (json['colours'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ColourEnumMap, e))
          .toList(),
      width: (json['width'] as num?)?.toInt(),
      extensiveness: (json['extensiveness'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      link: json['link'] as String?,
      notes: json['notes'] as String?,
      isFavorite: json['isFavorite'] as bool?,
      userId: json['userId'] as String?,
      isARemnant: json['isARemnant'] as bool?,
      fabricPattern:
          $enumDecodeNullable(_$FabricPatternEnumMap, json['fabricPattern']),
      fabricStatus:
          $enumDecodeNullable(_$FabricStatusEnumMap, json['fabricStatus']),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$FabricImplToJson(_$FabricImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'brand': instance.brand,
      'weave': instance.weave,
      'materials': instance.materials,
      'seasons': instance.seasons,
      'quantity': instance.quantity,
      'colours': instance.colours,
      'width': instance.width,
      'extensiveness': instance.extensiveness,
      'price': instance.price,
      'images': instance.images,
      'link': instance.link,
      'notes': instance.notes,
      'isFavorite': instance.isFavorite,
      'userId': instance.userId,
      'isARemnant': instance.isARemnant,
      'fabricPattern': instance.fabricPattern,
      'fabricStatus': instance.fabricStatus,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$FabricTypeEnumMap = {
  FabricType.woven: 'woven',
  FabricType.knitted: 'knitted',
  FabricType.nonWoven: 'nonWoven',
};

const _$SeasonEnumMap = {
  Season.spring: 'spring',
  Season.summer: 'summer',
  Season.autumn: 'autumn',
  Season.winter: 'winter',
};

const _$ColourEnumMap = {
  Colour.red: 'red',
  Colour.orange: 'orange',
  Colour.yellow: 'yellow',
  Colour.green: 'green',
  Colour.blue: 'blue',
  Colour.purple: 'purple',
  Colour.pink: 'pink',
  Colour.brown: 'brown',
  Colour.beige: 'beige',
  Colour.white: 'white',
  Colour.gray: 'gray',
  Colour.black: 'black',
};

const _$FabricPatternEnumMap = {
  FabricPattern.solid: 'solid',
  FabricPattern.stripes: 'stripes',
  FabricPattern.floral: 'floral',
  FabricPattern.dots: 'dots',
  FabricPattern.geometric: 'geometric',
  FabricPattern.animal: 'animal',
  FabricPattern.ethnic: 'ethnic',
  FabricPattern.vichy: 'vichy',
  FabricPattern.abstrait: 'abstrait',
  FabricPattern.childlish: 'childlish',
  FabricPattern.festive: 'festive',
  FabricPattern.other: 'other',
};

const _$FabricStatusEnumMap = {
  FabricStatus.ordered: 'ordered',
  FabricStatus.bought: 'bought',
  FabricStatus.washed: 'washed',
  FabricStatus.ironed: 'ironed',
};
