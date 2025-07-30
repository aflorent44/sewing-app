enum WearerCategory {
  woman,
  man,
  girl,
  boy,
  baby;

  static WearerCategory fromJson(String name) {
    return values.firstWhere((c) => c.name == name);
  }

  String toJson() => name;
}

extension WearerCategoryLabelExtension on WearerCategory {
  String get label {
    switch (this) {
      case WearerCategory.woman:
        return 'Femme';
      case WearerCategory.man:
        return 'Homme';
      case WearerCategory.girl:
        return 'Fille';
      case WearerCategory.boy:
        return 'Garçon';
      case WearerCategory.baby:
        return 'Bébé';
    }
  }
}
