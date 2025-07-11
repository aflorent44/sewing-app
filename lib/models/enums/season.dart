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
