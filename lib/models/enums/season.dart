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
        //retourne un emoji printemps
        return '🌸';
      case Season.summer:
        //emoji été
        return '🌞';
      case Season.autumn:
        //emoji automne
        return '🍂';
      case Season.winter:
        return '❄️';
    }
  }
}
