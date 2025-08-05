// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inspiration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Inspiration _$InspirationFromJson(Map<String, dynamic> json) {
  return _Inspiration.fromJson(json);
}

/// @nodoc
mixin _$Inspiration {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;
  PatternType? get projectType => throw _privateConstructorUsedError;
  List<ClothingType>? get clothingTypes => throw _privateConstructorUsedError;
  List<Colour>? get colours => throw _privateConstructorUsedError;
  List<Season>? get seasons => throw _privateConstructorUsedError;
  List<ImageModel>? get images => throw _privateConstructorUsedError;
  bool? get isFavorite => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;

  /// Serializes this Inspiration to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Inspiration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InspirationCopyWith<Inspiration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InspirationCopyWith<$Res> {
  factory $InspirationCopyWith(
          Inspiration value, $Res Function(Inspiration) then) =
      _$InspirationCopyWithImpl<$Res, Inspiration>;
  @useResult
  $Res call(
      {String? id,
      String name,
      String? notes,
      String? link,
      PatternType? projectType,
      List<ClothingType>? clothingTypes,
      List<Colour>? colours,
      List<Season>? seasons,
      List<ImageModel>? images,
      bool? isFavorite,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? userId});
}

/// @nodoc
class _$InspirationCopyWithImpl<$Res, $Val extends Inspiration>
    implements $InspirationCopyWith<$Res> {
  _$InspirationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Inspiration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? notes = freezed,
    Object? link = freezed,
    Object? projectType = freezed,
    Object? clothingTypes = freezed,
    Object? colours = freezed,
    Object? seasons = freezed,
    Object? images = freezed,
    Object? isFavorite = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? userId = freezed,
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
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      projectType: freezed == projectType
          ? _value.projectType
          : projectType // ignore: cast_nullable_to_non_nullable
              as PatternType?,
      clothingTypes: freezed == clothingTypes
          ? _value.clothingTypes
          : clothingTypes // ignore: cast_nullable_to_non_nullable
              as List<ClothingType>?,
      colours: freezed == colours
          ? _value.colours
          : colours // ignore: cast_nullable_to_non_nullable
              as List<Colour>?,
      seasons: freezed == seasons
          ? _value.seasons
          : seasons // ignore: cast_nullable_to_non_nullable
              as List<Season>?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>?,
      isFavorite: freezed == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InspirationImplCopyWith<$Res>
    implements $InspirationCopyWith<$Res> {
  factory _$$InspirationImplCopyWith(
          _$InspirationImpl value, $Res Function(_$InspirationImpl) then) =
      __$$InspirationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String name,
      String? notes,
      String? link,
      PatternType? projectType,
      List<ClothingType>? clothingTypes,
      List<Colour>? colours,
      List<Season>? seasons,
      List<ImageModel>? images,
      bool? isFavorite,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? userId});
}

/// @nodoc
class __$$InspirationImplCopyWithImpl<$Res>
    extends _$InspirationCopyWithImpl<$Res, _$InspirationImpl>
    implements _$$InspirationImplCopyWith<$Res> {
  __$$InspirationImplCopyWithImpl(
      _$InspirationImpl _value, $Res Function(_$InspirationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Inspiration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? notes = freezed,
    Object? link = freezed,
    Object? projectType = freezed,
    Object? clothingTypes = freezed,
    Object? colours = freezed,
    Object? seasons = freezed,
    Object? images = freezed,
    Object? isFavorite = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? userId = freezed,
  }) {
    return _then(_$InspirationImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      projectType: freezed == projectType
          ? _value.projectType
          : projectType // ignore: cast_nullable_to_non_nullable
              as PatternType?,
      clothingTypes: freezed == clothingTypes
          ? _value._clothingTypes
          : clothingTypes // ignore: cast_nullable_to_non_nullable
              as List<ClothingType>?,
      colours: freezed == colours
          ? _value._colours
          : colours // ignore: cast_nullable_to_non_nullable
              as List<Colour>?,
      seasons: freezed == seasons
          ? _value._seasons
          : seasons // ignore: cast_nullable_to_non_nullable
              as List<Season>?,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>?,
      isFavorite: freezed == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InspirationImpl implements _Inspiration {
  const _$InspirationImpl(
      {this.id,
      required this.name,
      this.notes,
      this.link,
      this.projectType,
      final List<ClothingType>? clothingTypes,
      final List<Colour>? colours,
      final List<Season>? seasons,
      final List<ImageModel>? images,
      this.isFavorite,
      this.createdAt,
      this.updatedAt,
      this.userId})
      : _clothingTypes = clothingTypes,
        _colours = colours,
        _seasons = seasons,
        _images = images;

  factory _$InspirationImpl.fromJson(Map<String, dynamic> json) =>
      _$$InspirationImplFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String? notes;
  @override
  final String? link;
  @override
  final PatternType? projectType;
  final List<ClothingType>? _clothingTypes;
  @override
  List<ClothingType>? get clothingTypes {
    final value = _clothingTypes;
    if (value == null) return null;
    if (_clothingTypes is EqualUnmodifiableListView) return _clothingTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Colour>? _colours;
  @override
  List<Colour>? get colours {
    final value = _colours;
    if (value == null) return null;
    if (_colours is EqualUnmodifiableListView) return _colours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Season>? _seasons;
  @override
  List<Season>? get seasons {
    final value = _seasons;
    if (value == null) return null;
    if (_seasons is EqualUnmodifiableListView) return _seasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

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
  final bool? isFavorite;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? userId;

  @override
  String toString() {
    return 'Inspiration(id: $id, name: $name, notes: $notes, link: $link, projectType: $projectType, clothingTypes: $clothingTypes, colours: $colours, seasons: $seasons, images: $images, isFavorite: $isFavorite, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InspirationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.projectType, projectType) ||
                other.projectType == projectType) &&
            const DeepCollectionEquality()
                .equals(other._clothingTypes, _clothingTypes) &&
            const DeepCollectionEquality().equals(other._colours, _colours) &&
            const DeepCollectionEquality().equals(other._seasons, _seasons) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      notes,
      link,
      projectType,
      const DeepCollectionEquality().hash(_clothingTypes),
      const DeepCollectionEquality().hash(_colours),
      const DeepCollectionEquality().hash(_seasons),
      const DeepCollectionEquality().hash(_images),
      isFavorite,
      createdAt,
      updatedAt,
      userId);

  /// Create a copy of Inspiration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InspirationImplCopyWith<_$InspirationImpl> get copyWith =>
      __$$InspirationImplCopyWithImpl<_$InspirationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InspirationImplToJson(
      this,
    );
  }
}

abstract class _Inspiration implements Inspiration {
  const factory _Inspiration(
      {final String? id,
      required final String name,
      final String? notes,
      final String? link,
      final PatternType? projectType,
      final List<ClothingType>? clothingTypes,
      final List<Colour>? colours,
      final List<Season>? seasons,
      final List<ImageModel>? images,
      final bool? isFavorite,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final String? userId}) = _$InspirationImpl;

  factory _Inspiration.fromJson(Map<String, dynamic> json) =
      _$InspirationImpl.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String? get notes;
  @override
  String? get link;
  @override
  PatternType? get projectType;
  @override
  List<ClothingType>? get clothingTypes;
  @override
  List<Colour>? get colours;
  @override
  List<Season>? get seasons;
  @override
  List<ImageModel>? get images;
  @override
  bool? get isFavorite;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  String? get userId;

  /// Create a copy of Inspiration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InspirationImplCopyWith<_$InspirationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
