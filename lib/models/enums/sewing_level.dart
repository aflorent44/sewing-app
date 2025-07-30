enum SewingLevel {
  easy,
  intermediate,
  advanced,
  expert;

  static SewingLevel fromJson(String name) {
    return SewingLevel.values.firstWhere((e) => e.name == name);
  }

  String toJson() => name;
}

extension SewingLevelLabelExtension on SewingLevel {
  String get label {
    switch (this) {
      case SewingLevel.easy:
        return 'Facile';
      case SewingLevel.intermediate:
        return 'Intermédiaire';
      case SewingLevel.advanced:
        return 'Avancé';
      case SewingLevel.expert:
        return 'Expert';
    }
  }
}

extension SewingLevelNumberExtension on SewingLevel {
  int get number {
    switch (this) {
      case SewingLevel.easy:
        return 1;
      case SewingLevel.intermediate:
        return 2;
      case SewingLevel.advanced:
        return 3;
      case SewingLevel.expert:
        return 4;
    }
  }
}
