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
