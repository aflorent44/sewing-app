// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspiration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InspirationImpl _$$InspirationImplFromJson(Map<String, dynamic> json) =>
    _$InspirationImpl(
      id: json['_id'] as String?,
      name: json['name'] as String,
      notes: json['notes'] as String?,
      link: json['link'] as String?,
      projectType:
          $enumDecodeNullable(_$PatternTypeEnumMap, json['projectType']),
      clothingTypes: (json['clothingTypes'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ClothingTypeEnumMap, e))
          .toList(),
      colours: (json['colours'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ColourEnumMap, e))
          .toList(),
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$SeasonEnumMap, e))
          .toList(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isFavorite: json['isFavorite'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$$InspirationImplToJson(_$InspirationImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'notes': instance.notes,
      'link': instance.link,
      'projectType': instance.projectType,
      'clothingTypes': instance.clothingTypes,
      'colours': instance.colours,
      'seasons': instance.seasons,
      'images': instance.images,
      'isFavorite': instance.isFavorite,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'userId': instance.userId,
    };

const _$PatternTypeEnumMap = {
  PatternType.clothing: 'clothing',
  PatternType.underwearAndSwimwear: 'underwearAndSwimwear',
  PatternType.accessories: 'accessories',
  PatternType.homedecor: 'homedecor',
  PatternType.animal: 'animal',
  PatternType.other: 'other',
};

const _$ClothingTypeEnumMap = {
  ClothingType.top: 'top',
  ClothingType.shirt: 'shirt',
  ClothingType.dress: 'dress',
  ClothingType.pants: 'pants',
  ClothingType.short: 'short',
  ClothingType.skirt: 'skirt',
  ClothingType.coat: 'coat',
  ClothingType.jacket: 'jacket',
  ClothingType.sweater: 'sweater',
  ClothingType.jumpsuit: 'jumpsuit',
  ClothingType.suit: 'suit',
  ClothingType.other: 'other',
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

const _$SeasonEnumMap = {
  Season.spring: 'spring',
  Season.summer: 'summer',
  Season.autumn: 'autumn',
  Season.winter: 'winter',
};
