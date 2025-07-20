import 'package:hive/hive.dart';

part 'season.g.dart';

@HiveType(typeId: 2)
enum Season {
  @HiveField(0)
  spring,
  @HiveField(1)
  summer,
  @HiveField(2)
  autumn,
  @HiveField(3)
  winter;

  static Season fromJson(String value) {
    return Season.values.firstWhere((e) => e.name == value);
  }

  String toJson() => name;
}

extension SeasonLabelExtension on Season {
  String get label {
    switch (this) {
      case Season.spring:
        return 'Printemps 🌸';
      case Season.summer:
        return 'Été 🌞';
      case Season.autumn:
        return 'Automne 🍂';
      case Season.winter:
        return 'Hiver ❄️';
    }
  }
}

extension SeasonEmojiExtension on Season {
  String get emoji {
    switch (this) {
      case Season.spring:
        return '🌸';
      case Season.summer:
        return '🌞';
      case Season.autumn:
        return '🍂';
      case Season.winter:
        return '❄️';
    }
  }
}

