enum FabricStatus {
  ordered,
  bought,
  washed,
  ironed;

  static FabricStatus fromJson(String name) {
    return FabricStatus.values.firstWhere((e) => e.name == name);
  }

  String toJson() => name;
}

extension FabricStatusExtension on FabricStatus {
  String get label {
    switch (this) {
      case FabricStatus.ordered:
        return 'Commandé';
      case FabricStatus.bought:
        return 'Acheté';
      case FabricStatus.washed:
        return 'Lavé';
      case FabricStatus.ironed:
        return 'Repassé';
    }
  }
}