enum PatternFormat {
  pdf,
  printed,
  livre,
  magazine,
  autre;

  static PatternFormat fromJson(String name) {
    return PatternFormat.values.firstWhere((e) => e.name == name);
  }

  String toJson() => name;
}

extension PatternFormatExtension on PatternFormat {
  String get label {
    switch (this) {
      case PatternFormat.pdf:
        return 'PDF';
      case PatternFormat.printed:
        return 'Patron pochette';
      case PatternFormat.magazine:
        return 'Magazine';
      case PatternFormat.livre:
        return 'Livre';
      case PatternFormat.autre:
        return 'Autre';
    }
  }
}
