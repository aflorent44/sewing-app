// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fabric.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Fabric _$FabricFromJson(Map<String, dynamic> json) {
  return _Fabric.fromJson(json);
}

/// @nodoc
mixin _$Fabric {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  FabricType? get type => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  String? get weave => throw _privateConstructorUsedError;
  List<MaterialModel>? get materials => throw _privateConstructorUsedError;
  List<Season>? get seasons => throw _privateConstructorUsedError;
  double? get quantity => throw _privateConstructorUsedError;
  List<Colour>? get colours => throw _privateConstructorUsedError;
  int? get width => throw _privateConstructorUsedError;
  double? get extensiveness => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  List<ImageModel>? get images => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  bool? get isFavorite => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  bool? get isARemnant => throw _privateConstructorUsedError;
  FabricPattern? get fabricPattern => throw _privateConstructorUsedError;
  FabricStatus? get fabricStatus => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Fabric to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Fabric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FabricCopyWith<Fabric> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FabricCopyWith<$Res> {
  factory $FabricCopyWith(Fabric value, $Res Function(Fabric) then) =
      _$FabricCopyWithImpl<$Res, Fabric>;
  @useResult
  $Res call(
      {String? id,
      String name,
      String? description,
      FabricType? type,
      String? brand,
      String? weave,
      List<MaterialModel>? materials,
      List<Season>? seasons,
      double? quantity,
      List<Colour>? colours,
      int? width,
      double? extensiveness,
      double? price,
      List<ImageModel>? images,
      String? link,
      String? notes,
      bool? isFavorite,
      String? userId,
      bool? isARemnant,
      FabricPattern? fabricPattern,
      FabricStatus? fabricStatus,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$FabricCopyWithImpl<$Res, $Val extends Fabric>
    implements $FabricCopyWith<$Res> {
  _$FabricCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Fabric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? type = freezed,
    Object? brand = freezed,
    Object? weave = freezed,
    Object? materials = freezed,
    Object? seasons = freezed,
    Object? quantity = freezed,
    Object? colours = freezed,
    Object? width = freezed,
    Object? extensiveness = freezed,
    Object? price = freezed,
    Object? images = freezed,
    Object? link = freezed,
    Object? notes = freezed,
    Object? isFavorite = freezed,
    Object? userId = freezed,
    Object? isARemnant = freezed,
    Object? fabricPattern = freezed,
    Object? fabricStatus = freezed,
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
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FabricType?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      weave: freezed == weave
          ? _value.weave
          : weave // ignore: cast_nullable_to_non_nullable
              as String?,
      materials: freezed == materials
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as List<MaterialModel>?,
      seasons: freezed == seasons
          ? _value.seasons
          : seasons // ignore: cast_nullable_to_non_nullable
              as List<Season>?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      colours: freezed == colours
          ? _value.colours
          : colours // ignore: cast_nullable_to_non_nullable
              as List<Colour>?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      extensiveness: freezed == extensiveness
          ? _value.extensiveness
          : extensiveness // ignore: cast_nullable_to_non_nullable
              as double?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: freezed == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      isARemnant: freezed == isARemnant
          ? _value.isARemnant
          : isARemnant // ignore: cast_nullable_to_non_nullable
              as bool?,
      fabricPattern: freezed == fabricPattern
          ? _value.fabricPattern
          : fabricPattern // ignore: cast_nullable_to_non_nullable
              as FabricPattern?,
      fabricStatus: freezed == fabricStatus
          ? _value.fabricStatus
          : fabricStatus // ignore: cast_nullable_to_non_nullable
              as FabricStatus?,
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
abstract class _$$FabricImplCopyWith<$Res> implements $FabricCopyWith<$Res> {
  factory _$$FabricImplCopyWith(
          _$FabricImpl value, $Res Function(_$FabricImpl) then) =
      __$$FabricImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String name,
      String? description,
      FabricType? type,
      String? brand,
      String? weave,
      List<MaterialModel>? materials,
      List<Season>? seasons,
      double? quantity,
      List<Colour>? colours,
      int? width,
      double? extensiveness,
      double? price,
      List<ImageModel>? images,
      String? link,
      String? notes,
      bool? isFavorite,
      String? userId,
      bool? isARemnant,
      FabricPattern? fabricPattern,
      FabricStatus? fabricStatus,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$FabricImplCopyWithImpl<$Res>
    extends _$FabricCopyWithImpl<$Res, _$FabricImpl>
    implements _$$FabricImplCopyWith<$Res> {
  __$$FabricImplCopyWithImpl(
      _$FabricImpl _value, $Res Function(_$FabricImpl) _then)
      : super(_value, _then);

  /// Create a copy of Fabric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? type = freezed,
    Object? brand = freezed,
    Object? weave = freezed,
    Object? materials = freezed,
    Object? seasons = freezed,
    Object? quantity = freezed,
    Object? colours = freezed,
    Object? width = freezed,
    Object? extensiveness = freezed,
    Object? price = freezed,
    Object? images = freezed,
    Object? link = freezed,
    Object? notes = freezed,
    Object? isFavorite = freezed,
    Object? userId = freezed,
    Object? isARemnant = freezed,
    Object? fabricPattern = freezed,
    Object? fabricStatus = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$FabricImpl(
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
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FabricType?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      weave: freezed == weave
          ? _value.weave
          : weave // ignore: cast_nullable_to_non_nullable
              as String?,
      materials: freezed == materials
          ? _value._materials
          : materials // ignore: cast_nullable_to_non_nullable
              as List<MaterialModel>?,
      seasons: freezed == seasons
          ? _value._seasons
          : seasons // ignore: cast_nullable_to_non_nullable
              as List<Season>?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      colours: freezed == colours
          ? _value._colours
          : colours // ignore: cast_nullable_to_non_nullable
              as List<Colour>?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      extensiveness: freezed == extensiveness
          ? _value.extensiveness
          : extensiveness // ignore: cast_nullable_to_non_nullable
              as double?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: freezed == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      isARemnant: freezed == isARemnant
          ? _value.isARemnant
          : isARemnant // ignore: cast_nullable_to_non_nullable
              as bool?,
      fabricPattern: freezed == fabricPattern
          ? _value.fabricPattern
          : fabricPattern // ignore: cast_nullable_to_non_nullable
              as FabricPattern?,
      fabricStatus: freezed == fabricStatus
          ? _value.fabricStatus
          : fabricStatus // ignore: cast_nullable_to_non_nullable
              as FabricStatus?,
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
class _$FabricImpl implements _Fabric {
  const _$FabricImpl(
      {this.id,
      required this.name,
      this.description,
      this.type,
      this.brand,
      this.weave,
      final List<MaterialModel>? materials,
      final List<Season>? seasons,
      this.quantity,
      final List<Colour>? colours,
      this.width,
      this.extensiveness,
      this.price,
      final List<ImageModel>? images,
      this.link,
      this.notes,
      this.isFavorite,
      this.userId,
      this.isARemnant,
      this.fabricPattern,
      this.fabricStatus,
      this.createdAt,
      this.updatedAt})
      : _materials = materials,
        _seasons = seasons,
        _colours = colours,
        _images = images;

  factory _$FabricImpl.fromJson(Map<String, dynamic> json) =>
      _$$FabricImplFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final FabricType? type;
  @override
  final String? brand;
  @override
  final String? weave;
  final List<MaterialModel>? _materials;
  @override
  List<MaterialModel>? get materials {
    final value = _materials;
    if (value == null) return null;
    if (_materials is EqualUnmodifiableListView) return _materials;
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

  @override
  final double? quantity;
  final List<Colour>? _colours;
  @override
  List<Colour>? get colours {
    final value = _colours;
    if (value == null) return null;
    if (_colours is EqualUnmodifiableListView) return _colours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? width;
  @override
  final double? extensiveness;
  @override
  final double? price;
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
  final String? link;
  @override
  final String? notes;
  @override
  final bool? isFavorite;
  @override
  final String? userId;
  @override
  final bool? isARemnant;
  @override
  final FabricPattern? fabricPattern;
  @override
  final FabricStatus? fabricStatus;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Fabric(id: $id, name: $name, description: $description, type: $type, brand: $brand, weave: $weave, materials: $materials, seasons: $seasons, quantity: $quantity, colours: $colours, width: $width, extensiveness: $extensiveness, price: $price, images: $images, link: $link, notes: $notes, isFavorite: $isFavorite, userId: $userId, isARemnant: $isARemnant, fabricPattern: $fabricPattern, fabricStatus: $fabricStatus, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FabricImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.weave, weave) || other.weave == weave) &&
            const DeepCollectionEquality()
                .equals(other._materials, _materials) &&
            const DeepCollectionEquality().equals(other._seasons, _seasons) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            const DeepCollectionEquality().equals(other._colours, _colours) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.extensiveness, extensiveness) ||
                other.extensiveness == extensiveness) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isARemnant, isARemnant) ||
                other.isARemnant == isARemnant) &&
            (identical(other.fabricPattern, fabricPattern) ||
                other.fabricPattern == fabricPattern) &&
            (identical(other.fabricStatus, fabricStatus) ||
                other.fabricStatus == fabricStatus) &&
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
        type,
        brand,
        weave,
        const DeepCollectionEquality().hash(_materials),
        const DeepCollectionEquality().hash(_seasons),
        quantity,
        const DeepCollectionEquality().hash(_colours),
        width,
        extensiveness,
        price,
        const DeepCollectionEquality().hash(_images),
        link,
        notes,
        isFavorite,
        userId,
        isARemnant,
        fabricPattern,
        fabricStatus,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of Fabric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FabricImplCopyWith<_$FabricImpl> get copyWith =>
      __$$FabricImplCopyWithImpl<_$FabricImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FabricImplToJson(
      this,
    );
  }
}

abstract class _Fabric implements Fabric {
  const factory _Fabric(
      {final String? id,
      required final String name,
      final String? description,
      final FabricType? type,
      final String? brand,
      final String? weave,
      final List<MaterialModel>? materials,
      final List<Season>? seasons,
      final double? quantity,
      final List<Colour>? colours,
      final int? width,
      final double? extensiveness,
      final double? price,
      final List<ImageModel>? images,
      final String? link,
      final String? notes,
      final bool? isFavorite,
      final String? userId,
      final bool? isARemnant,
      final FabricPattern? fabricPattern,
      final FabricStatus? fabricStatus,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$FabricImpl;

  factory _Fabric.fromJson(Map<String, dynamic> json) = _$FabricImpl.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  FabricType? get type;
  @override
  String? get brand;
  @override
  String? get weave;
  @override
  List<MaterialModel>? get materials;
  @override
  List<Season>? get seasons;
  @override
  double? get quantity;
  @override
  List<Colour>? get colours;
  @override
  int? get width;
  @override
  double? get extensiveness;
  @override
  double? get price;
  @override
  List<ImageModel>? get images;
  @override
  String? get link;
  @override
  String? get notes;
  @override
  bool? get isFavorite;
  @override
  String? get userId;
  @override
  bool? get isARemnant;
  @override
  FabricPattern? get fabricPattern;
  @override
  FabricStatus? get fabricStatus;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Fabric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FabricImplCopyWith<_$FabricImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
