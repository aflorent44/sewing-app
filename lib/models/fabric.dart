import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/enums/fabric_pattern.dart';
import 'package:mon_app_couture/models/enums/fabric_status.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/models/material_model.dart';
import 'package:mon_app_couture/models/enums/fabric_type.dart';
import 'package:mon_app_couture/models/image_model.dart';

part 'fabric.freezed.dart';
part 'fabric.g.dart';

@freezed
class Fabric with _$Fabric {
  const factory Fabric({
    String? id,
    required String name,
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
    DateTime? updatedAt,
  }) = _Fabric;

  factory Fabric.fromJson(Map<String, dynamic> json) => _$FabricFromJson(json);
}
