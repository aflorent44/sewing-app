enum PatternStatus { 
  ordered,
  bought,
  received,
  printed,
  cut,
  assembled,
  transfered;

  static PatternStatus fromJson(String name) {
    return PatternStatus.values.firstWhere((e) => e.name == name);
  }

  String toJson() => name;
}

extension PatternStatusExtension on PatternStatus {
  String get label {
    switch (this) {
      case PatternStatus.ordered:
        return 'Commandé';
      case PatternStatus.bought:
        return 'Acheté';
      case PatternStatus.received:
        return 'Reçu';
      case PatternStatus.printed:
        return 'Imprimé';
      case PatternStatus.cut:
        return 'Coupé (A0)';
      case PatternStatus.assembled:
        return 'Assemblé (A4)';
      case PatternStatus.transfered:
        return 'Décalqué';
    }
  }
}