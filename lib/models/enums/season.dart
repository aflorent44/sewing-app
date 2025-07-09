enum Season {
  spring,
  summer,
  autumn,
  winter;

  static Season fromJson(String value) {
    return Season.values.firstWhere((e) => e.name == value);
  }

  String toJson() => name;

  
}

extension SeasonExtension on Season {
  String get label {
    switch (this) {
      case Season.spring:
        return 'Printemps';
      case Season.summer:
        return 'Été';
      case Season.autumn:
        return 'Automne';
      case Season.winter:
        return 'Hiver';
    }
  }
}
