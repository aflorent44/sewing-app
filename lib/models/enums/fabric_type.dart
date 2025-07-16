import 'package:hive/hive.dart';

part 'fabric_type.g.dart';

@HiveType(typeId: 4)
enum FabricType {
  @HiveField(0)
  woven,
  @HiveField(1)
  knitted,
  @HiveField(2)
  nonWoven;

  static FabricType fromJson(String name) {
    return FabricType.values.firstWhere((e) => e.name == name);
  }

  String toJson() => name;
}

extension FabricTypeExtension on FabricType {
  String get label {
    switch (this) {
      case FabricType.woven:
        return 'Chaine et trame';
      case FabricType.knitted:
        return 'Maille';
      case FabricType.nonWoven:
        return 'Intissé';
    }
  }
}