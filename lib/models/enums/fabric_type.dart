enum FabricType {
  woven,
  knitted,
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