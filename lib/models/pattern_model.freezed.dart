// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pattern_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PatternModel _$PatternModelFromJson(Map<String, dynamic> json) {
  return _PatternModel.fromJson(json);
}

/// @nodoc
mixin _$PatternModel {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  PatternFormat? get format => throw _privateConstructorUsedError;
  PatternStatus? get status => throw _privateConstructorUsedError;
  String? get sizeRange => throw _privateConstructorUsedError;
  List<Season>? get seasons => throw _privateConstructorUsedError;
  List<FabricType>? get fabricTypes => throw _privateConstructorUsedError;
  PatternType? get projectType => throw _privateConstructorUsedError;
  List<WearerCategory>? get wearerCategories =>
      throw _privateConstructorUsedError;
  List<ClothingType>? get clothingTypes => throw _privateConstructorUsedError;
  SewingLevel? get sewingLevel => throw _privateConstructorUsedError;
  List<ImageModel>? get images => throw _privateConstructorUsedError;
  String? get linkToShop => throw _privateConstructorUsedError;
  List<String>? get necessarySupplies => throw _privateConstructorUsedError;
  bool? get areSeamAllowancesIncluded => throw _privateConstructorUsedError;
  bool? get isFavorite => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PatternModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PatternModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatternModelCopyWith<PatternModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatternModelCopyWith<$Res> {
  factory $PatternModelCopyWith(
          PatternModel value, $Res Function(PatternModel) then) =
      _$PatternModelCopyWithImpl<$Res, PatternModel>;
  @useResult
  $Res call(
      {String? id,
      String name,
      String? description,
      String? brand,
      PatternFormat? format,
      PatternStatus? status,
      String? sizeRange,
      List<Season>? seasons,
      List<FabricType>? fabricTypes,
      PatternType? projectType,
      List<WearerCategory>? wearerCategories,
      List<ClothingType>? clothingTypes,
      SewingLevel? sewingLevel,
      List<ImageModel>? images,
      String? linkToShop,
      List<String>? necessarySupplies,
      bool? areSeamAllowancesIncluded,
      bool? isFavorite,
      String? userId,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$PatternModelCopyWithImpl<$Res, $Val extends PatternModel>
    implements $PatternModelCopyWith<$Res> {
  _$PatternModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatternModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? brand = freezed,
    Object? format = freezed,
    Object? status = freezed,
    Object? sizeRange = freezed,
    Object? seasons = freezed,
    Object? fabricTypes = freezed,
    Object? projectType = freezed,
    Object? wearerCategories = freezed,
    Object? clothingTypes = freezed,
    Object? sewingLevel = freezed,
    Object? images = freezed,
    Object? linkToShop = freezed,
    Object? necessarySupplies = freezed,
    Object? areSeamAllowancesIncluded = freezed,
    Object? isFavorite = freezed,
    Object? userId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      format: freezed == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as PatternFormat?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PatternStatus?,
      sizeRange: freezed == sizeRange
          ? _value.sizeRange
          : sizeRange // ignore: cast_nullable_to_non_nullable
              as String?,
      seasons: freezed == seasons
          ? _value.seasons
          : seasons // ignore: cast_nullable_to_non_nullable
              as List<Season>?,
      fabricTypes: freezed == fabricTypes
          ? _value.fabricTypes
          : fabricTypes // ignore: cast_nullable_to_non_nullable
              as List<FabricType>?,
      projectType: freezed == projectType
          ? _value.projectType
          : projectType // ignore: cast_nullable_to_non_nullable
              as PatternType?,
      wearerCategories: freezed == wearerCategories
          ? _value.wearerCategories
          : wearerCategories // ignore: cast_nullable_to_non_nullable
              as List<WearerCategory>?,
      clothingTypes: freezed == clothingTypes
          ? _value.clothingTypes
          : clothingTypes // ignore: cast_nullable_to_non_nullable
              as List<ClothingType>?,
      sewingLevel: freezed == sewingLevel
          ? _value.sewingLevel
          : sewingLevel // ignore: cast_nullable_to_non_nullable
              as SewingLevel?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>?,
      linkToShop: freezed == linkToShop
          ? _value.linkToShop
          : linkToShop // ignore: cast_nullable_to_non_nullable
              as String?,
      necessarySupplies: freezed == necessarySupplies
          ? _value.necessarySupplies
          : necessarySupplies // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      areSeamAllowancesIncluded: freezed == areSeamAllowancesIncluded
          ? _value.areSeamAllowancesIncluded
          : areSeamAllowancesIncluded // ignore: cast_nullable_to_non_nullable
              as bool?,
      isFavorite: freezed == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PatternModelImplCopyWith<$Res>
    implements $PatternModelCopyWith<$Res> {
  factory _$$PatternModelImplCopyWith(
          _$PatternModelImpl value, $Res Function(_$PatternModelImpl) then) =
      __$$PatternModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String name,
      String? description,
      String? brand,
      PatternFormat? format,
      PatternStatus? status,
      String? sizeRange,
      List<Season>? seasons,
      List<FabricType>? fabricTypes,
      PatternType? projectType,
      List<WearerCategory>? wearerCategories,
      List<ClothingType>? clothingTypes,
      SewingLevel? sewingLevel,
      List<ImageModel>? images,
      String? linkToShop,
      List<String>? necessarySupplies,
      bool? areSeamAllowancesIncluded,
      bool? isFavorite,
      String? userId,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$PatternModelImplCopyWithImpl<$Res>
    extends _$PatternModelCopyWithImpl<$Res, _$PatternModelImpl>
    implements _$$PatternModelImplCopyWith<$Res> {
  __$$PatternModelImplCopyWithImpl(
      _$PatternModelImpl _value, $Res Function(_$PatternModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? brand = freezed,
    Object? format = freezed,
    Object? status = freezed,
    Object? sizeRange = freezed,
    Object? seasons = freezed,
    Object? fabricTypes = freezed,
    Object? projectType = freezed,
    Object? wearerCategories = freezed,
    Object? clothingTypes = freezed,
    Object? sewingLevel = freezed,
    Object? images = freezed,
    Object? linkToShop = freezed,
    Object? necessarySupplies = freezed,
    Object? areSeamAllowancesIncluded = freezed,
    Object? isFavorite = freezed,
    Object? userId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$PatternModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      format: freezed == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as PatternFormat?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PatternStatus?,
      sizeRange: freezed == sizeRange
          ? _value.sizeRange
          : sizeRange // ignore: cast_nullable_to_non_nullable
              as String?,
      seasons: freezed == seasons
          ? _value._seasons
          : seasons // ignore: cast_nullable_to_non_nullable
              as List<Season>?,
      fabricTypes: freezed == fabricTypes
          ? _value._fabricTypes
          : fabricTypes // ignore: cast_nullable_to_non_nullable
              as List<FabricType>?,
      projectType: freezed == projectType
          ? _value.projectType
          : projectType // ignore: cast_nullable_to_non_nullable
              as PatternType?,
      wearerCategories: freezed == wearerCategories
          ? _value._wearerCategories
          : wearerCategories // ignore: cast_nullable_to_non_nullable
              as List<WearerCategory>?,
      clothingTypes: freezed == clothingTypes
          ? _value._clothingTypes
          : clothingTypes // ignore: cast_nullable_to_non_nullable
              as List<ClothingType>?,
      sewingLevel: freezed == sewingLevel
          ? _value.sewingLevel
          : sewingLevel // ignore: cast_nullable_to_non_nullable
              as SewingLevel?,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>?,
      linkToShop: freezed == linkToShop
          ? _value.linkToShop
          : linkToShop // ignore: cast_nullable_to_non_nullable
              as String?,
      necessarySupplies: freezed == necessarySupplies
          ? _value._necessarySupplies
          : necessarySupplies // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      areSeamAllowancesIncluded: freezed == areSeamAllowancesIncluded
          ? _value.areSeamAllowancesIncluded
          : areSeamAllowancesIncluded // ignore: cast_nullable_to_non_nullable
              as bool?,
      isFavorite: freezed == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PatternModelImpl implements _PatternModel {
  const _$PatternModelImpl(
      {this.id,
      required this.name,
      this.description,
      this.brand,
      this.format,
      this.status,
      this.sizeRange,
      final List<Season>? seasons,
      final List<FabricType>? fabricTypes,
      this.projectType,
      final List<WearerCategory>? wearerCategories,
      final List<ClothingType>? clothingTypes,
      this.sewingLevel,
      final List<ImageModel>? images,
      this.linkToShop,
      final List<String>? necessarySupplies,
      this.areSeamAllowancesIncluded,
      this.isFavorite,
      this.userId,
      this.createdAt,
      this.updatedAt})
      : _seasons = seasons,
        _fabricTypes = fabricTypes,
        _wearerCategories = wearerCategories,
        _clothingTypes = clothingTypes,
        _images = images,
        _necessarySupplies = necessarySupplies;

  factory _$PatternModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatternModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? brand;
  @override
  final PatternFormat? format;
  @override
  final PatternStatus? status;
  @override
  final String? sizeRange;
  final List<Season>? _seasons;
  @override
  List<Season>? get seasons {
    final value = _seasons;
    if (value == null) return null;
    if (_seasons is EqualUnmodifiableListView) return _seasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<FabricType>? _fabricTypes;
  @override
  List<FabricType>? get fabricTypes {
    final value = _fabricTypes;
    if (value == null) return null;
    if (_fabricTypes is EqualUnmodifiableListView) return _fabricTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final PatternType? projectType;
  final List<WearerCategory>? _wearerCategories;
  @override
  List<WearerCategory>? get wearerCategories {
    final value = _wearerCategories;
    if (value == null) return null;
    if (_wearerCategories is EqualUnmodifiableListView)
      return _wearerCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ClothingType>? _clothingTypes;
  @override
  List<ClothingType>? get clothingTypes {
    final value = _clothingTypes;
    if (value == null) return null;
    if (_clothingTypes is EqualUnmodifiableListView) return _clothingTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final SewingLevel? sewingLevel;
  final List<ImageModel>? _images;
  @override
  List<ImageModel>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? linkToShop;
  final List<String>? _necessarySupplies;
  @override
  List<String>? get necessarySupplies {
    final value = _necessarySupplies;
    if (value == null) return null;
    if (_necessarySupplies is EqualUnmodifiableListView)
      return _necessarySupplies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? areSeamAllowancesIncluded;
  @override
  final bool? isFavorite;
  @override
  final String? userId;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'PatternModel(id: $id, name: $name, description: $description, brand: $brand, format: $format, status: $status, sizeRange: $sizeRange, seasons: $seasons, fabricTypes: $fabricTypes, projectType: $projectType, wearerCategories: $wearerCategories, clothingTypes: $clothingTypes, sewingLevel: $sewingLevel, images: $images, linkToShop: $linkToShop, necessarySupplies: $necessarySupplies, areSeamAllowancesIncluded: $areSeamAllowancesIncluded, isFavorite: $isFavorite, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatternModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.sizeRange, sizeRange) ||
                other.sizeRange == sizeRange) &&
            const DeepCollectionEquality().equals(other._seasons, _seasons) &&
            const DeepCollectionEquality()
                .equals(other._fabricTypes, _fabricTypes) &&
            (identical(other.projectType, projectType) ||
                other.projectType == projectType) &&
            const DeepCollectionEquality()
                .equals(other._wearerCategories, _wearerCategories) &&
            const DeepCollectionEquality()
                .equals(other._clothingTypes, _clothingTypes) &&
            (identical(other.sewingLevel, sewingLevel) ||
                other.sewingLevel == sewingLevel) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.linkToShop, linkToShop) ||
                other.linkToShop == linkToShop) &&
            const DeepCollectionEquality()
                .equals(other._necessarySupplies, _necessarySupplies) &&
            (identical(other.areSeamAllowancesIncluded,
                    areSeamAllowancesIncluded) ||
                other.areSeamAllowancesIncluded == areSeamAllowancesIncluded) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        description,
        brand,
        format,
        status,
        sizeRange,
        const DeepCollectionEquality().hash(_seasons),
        const DeepCollectionEquality().hash(_fabricTypes),
        projectType,
        const DeepCollectionEquality().hash(_wearerCategories),
        const DeepCollectionEquality().hash(_clothingTypes),
        sewingLevel,
        const DeepCollectionEquality().hash(_images),
        linkToShop,
        const DeepCollectionEquality().hash(_necessarySupplies),
        areSeamAllowancesIncluded,
        isFavorite,
        userId,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of PatternModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatternModelImplCopyWith<_$PatternModelImpl> get copyWith =>
      __$$PatternModelImplCopyWithImpl<_$PatternModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PatternModelImplToJson(
      this,
    );
  }
}

abstract class _PatternModel implements PatternModel {
  const factory _PatternModel(
      {final String? id,
      required final String name,
      final String? description,
      final String? brand,
      final PatternFormat? format,
      final PatternStatus? status,
      final String? sizeRange,
      final List<Season>? seasons,
      final List<FabricType>? fabricTypes,
      final PatternType? projectType,
      final List<WearerCategory>? wearerCategories,
      final List<ClothingType>? clothingTypes,
      final SewingLevel? sewingLevel,
      final List<ImageModel>? images,
      final String? linkToShop,
      final List<String>? necessarySupplies,
      final bool? areSeamAllowancesIncluded,
      final bool? isFavorite,
      final String? userId,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$PatternModelImpl;

  factory _PatternModel.fromJson(Map<String, dynamic> json) =
      _$PatternModelImpl.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get brand;
  @override
  PatternFormat? get format;
  @override
  PatternStatus? get status;
  @override
  String? get sizeRange;
  @override
  List<Season>? get seasons;
  @override
  List<FabricType>? get fabricTypes;
  @override
  PatternType? get projectType;
  @override
  List<WearerCategory>? get wearerCategories;
  @override
  List<ClothingType>? get clothingTypes;
  @override
  SewingLevel? get sewingLevel;
  @override
  List<ImageModel>? get images;
  @override
  String? get linkToShop;
  @override
  List<String>? get necessarySupplies;
  @override
  bool? get areSeamAllowancesIncluded;
  @override
  bool? get isFavorite;
  @override
  String? get userId;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of PatternModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatternModelImplCopyWith<_$PatternModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
