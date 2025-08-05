// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pattern_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatternModelImpl _$$PatternModelImplFromJson(Map<String, dynamic> json) =>
    _$PatternModelImpl(
      id: json['_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      brand: json['brand'] as String?,
      format: $enumDecodeNullable(_$PatternFormatEnumMap, json['format']),
      status: $enumDecodeNullable(_$PatternStatusEnumMap, json['status']),
      sizeRange: json['sizeRange'] as String?,
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$SeasonEnumMap, e))
          .toList(),
      fabricTypes: (json['fabricTypes'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$FabricTypeEnumMap, e))
          .toList(),
      projectType:
          $enumDecodeNullable(_$PatternTypeEnumMap, json['projectType']),
      wearerCategories: (json['wearerCategories'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$WearerCategoryEnumMap, e))
          .toList(),
      clothingTypes: (json['clothingTypes'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ClothingTypeEnumMap, e))
          .toList(),
      sewingLevel:
          $enumDecodeNullable(_$SewingLevelEnumMap, json['sewingLevel']),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      linkToShop: json['linkToShop'] as String?,
      necessarySupplies: (json['necessarySupplies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      areSeamAllowancesIncluded: json['areSeamAllowancesIncluded'] as bool?,
      isFavorite: json['isFavorite'] as bool?,
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PatternModelImplToJson(_$PatternModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'brand': instance.brand,
      'format': instance.format,
      'status': instance.status,
      'sizeRange': instance.sizeRange,
      'seasons': instance.seasons,
      'fabricTypes': instance.fabricTypes,
      'projectType': instance.projectType,
      'wearerCategories': instance.wearerCategories,
      'clothingTypes': instance.clothingTypes,
      'sewingLevel': instance.sewingLevel,
      'images': instance.images,
      'linkToShop': instance.linkToShop,
      'necessarySupplies': instance.necessarySupplies,
      'areSeamAllowancesIncluded': instance.areSeamAllowancesIncluded,
      'isFavorite': instance.isFavorite,
      'userId': instance.userId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$PatternFormatEnumMap = {
  PatternFormat.pdf: 'pdf',
  PatternFormat.printed: 'printed',
  PatternFormat.book: 'book',
  PatternFormat.magazine: 'magazine',
  PatternFormat.other: 'other',
};

const _$PatternStatusEnumMap = {
  PatternStatus.ordered: 'ordered',
  PatternStatus.bought: 'bought',
  PatternStatus.received: 'received',
  PatternStatus.printed: 'printed',
  PatternStatus.cut: 'cut',
  PatternStatus.assembled: 'assembled',
  PatternStatus.transfered: 'transfered',
};

const _$SeasonEnumMap = {
  Season.spring: 'spring',
  Season.summer: 'summer',
  Season.autumn: 'autumn',
  Season.winter: 'winter',
};

const _$FabricTypeEnumMap = {
  FabricType.woven: 'woven',
  FabricType.knitted: 'knitted',
  FabricType.nonWoven: 'nonWoven',
};

const _$PatternTypeEnumMap = {
  PatternType.clothing: 'clothing',
  PatternType.underwearAndSwimwear: 'underwearAndSwimwear',
  PatternType.accessories: 'accessories',
  PatternType.homedecor: 'homedecor',
  PatternType.animal: 'animal',
  PatternType.other: 'other',
};

const _$WearerCategoryEnumMap = {
  WearerCategory.woman: 'woman',
  WearerCategory.man: 'man',
  WearerCategory.girl: 'girl',
  WearerCategory.boy: 'boy',
  WearerCategory.baby: 'baby',
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

const _$SewingLevelEnumMap = {
  SewingLevel.easy: 'easy',
  SewingLevel.intermediate: 'intermediate',
  SewingLevel.advanced: 'advanced',
  SewingLevel.expert: 'expert',
};
