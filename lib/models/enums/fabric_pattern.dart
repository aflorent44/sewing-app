enum FabricPattern {
  solid,
  stripes, 
  floral,
  dots, 
  geometric,
  animal,
  ethnic,
  vichy,
  abstrait,
  childlish,
  festive,
  other;

  static FabricPattern? fromJson(String? json) {
    if (json == null) return null;
    return values.firstWhere((p) => p.name == json);
  }

  String toJson() => name;
}

extension FabricPatternExtension on FabricPattern {
  String get label {
    switch (this) {
      case FabricPattern.solid:
        return 'Uni';
      case FabricPattern.stripes:
        return 'Rayures';
      case FabricPattern.floral:
        return 'Fleurs';
      case FabricPattern.dots:
        return 'Pois';
      case FabricPattern.geometric:
        return 'Geométrique';
      case FabricPattern.animal:
        return 'Animaux';
      case FabricPattern.ethnic:
        return 'Ethnique';
      case FabricPattern.vichy:
        return 'Vichy';
      case FabricPattern.abstrait:
        return 'Abstrait';
      case FabricPattern.childlish:
        return 'Enfants';
      case FabricPattern.festive:
        return 'Festif';
      case FabricPattern.other:
        return 'Autre';
    }
  }
}