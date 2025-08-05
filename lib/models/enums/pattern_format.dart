enum PatternFormat {
  pdf,
  printed,
  book,
  magazine,
  other;

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
      case PatternFormat.book:
        return 'Livre';
      case PatternFormat.other:
        return 'Autre';
    }
  }
}
