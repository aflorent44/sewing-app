enum ClothingType { 
  top, 
  shirt,
  dress, 
  pants, 
  short,
  skirt,
  coat, 
  jacket, 
  sweater, 
  jumpsuit,
  suit,
  other;

  static ClothingType fromJson(String name) {
    return ClothingType.values.firstWhere((e) => e.name == name);
  }

  String toJson() => name;
}

extension ClothingTypeExtension on ClothingType {
  String get label {
    switch (this) {
      case ClothingType.top:
        return 'Top/t-shirt';
      case ClothingType.shirt:
        return 'Chemise';
      case ClothingType.dress:
        return 'Robe';
      case ClothingType.pants:
        return 'Pantalon';
      case ClothingType.short:
        return 'Short';
      case ClothingType.skirt:
        return 'Jupe';
      case ClothingType.coat:
        return 'Manteau';
      case ClothingType.jacket:
        return 'Veste';
      case ClothingType.sweater:
        return 'Sweat-shirt';
      case ClothingType.jumpsuit:
        return 'Combinaison';
      case ClothingType.suit:
        return 'Costume/Ensemble';
      case ClothingType.other:
        return 'Autre';
    }
  }
}