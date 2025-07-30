enum PatternType {
  clothing,
  underwearAndSwimwear,
  accessories,
  homedecor,
  animal,
  other;

  static PatternType fromJson(String name) {
    return PatternType.values.firstWhere((e) => e.name == name);
  }

  String toJson() => name;
}

extension PatternStatusExtension on PatternType {
  String get label {
    switch (this) {
      case PatternType.clothing:
        return 'Vêtement';
      case PatternType.underwearAndSwimwear:
        return 'Lingerie/Maillot de bain';
      case PatternType.accessories:
        return 'Accessoire';
      case PatternType.homedecor:
        return 'Décoration';
      case PatternType.animal:
        return 'Animal';
      case PatternType.other:
        return 'Autre';
    }
  }
}
